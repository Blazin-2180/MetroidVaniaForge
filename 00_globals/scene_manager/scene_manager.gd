extends CanvasLayer

#region

## SIGNALS ##
signal load_scene_started
signal new_scene_ready( target_name : String, offset : Vector2 )
signal load_scene_finished

## ON READY VARIABLES ##
@onready var fade: Control = $fade

## STANDARD VARIABLES ##
var fade_speed : float = 0.2

#endregion

func _ready() -> void:
	fade.visible = false
	await get_tree().process_frame
	load_scene_finished.emit()
	pass

func transition_scene( new_scene : String, target_area : String, player_offset : Vector2, direction : String ) -> void :
	# Fade new scene out
	get_tree().paused = true
	var fade_position : Vector2 = get_fade_position( direction )
	fade.visible = true
	load_scene_started.emit()
	await fade_screen( fade_position, Vector2.ZERO )
	# Change scene
	get_tree().change_scene_to_file( new_scene )
	await get_tree().scene_changed
	# Fade new scene in
	new_scene_ready.emit( target_area, player_offset )
	await fade_screen( Vector2.ZERO, -fade_position )
	fade.visible = false
	get_tree().paused = false
	load_scene_finished.emit()
	pass


func fade_screen(from : Vector2, to : Vector2 ) -> Signal :
	fade.position = from
	var tween : Tween = create_tween()
	tween.tween_property( fade, "position", to, fade_speed )
	return tween.finished


func get_fade_position( direction : String ) -> Vector2 :
	var position : Vector2 = Vector2( 480 * 2, 270 * 2 )
	
	match direction :
		"Left" : 
			position *= Vector2( -1, 0 )
		"Right" :
			position *= Vector2( 1, 0 )
		"Up" :
			position *= Vector2( -1, 0)
		"Down" :
			position *= Vector2( 1, 0 )
	return position
