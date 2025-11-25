@tool
@icon ("res://general/icons/level_transition.svg")
class_name LevelTransition extends Node2D

#region

## ENUMERABLES ##
enum SIDE { LEFT, RIGHT, UP, DOWN }

## EXPORT VARIABLES ##
@export_range( 2, 12, 1, "or_greater" ) var size : int = 2 :
	set( value ) :
		size = value
		apply_area_settings()

@export var location : SIDE = SIDE.LEFT :
	set( value ) :
		location = value
		apply_area_settings()

@export_file("*.tscn") var target_scene : String = ""
@export var target_area_name : String = "LevelTransition"

## ONREADY VARIABLES ##
@onready var area: Area2D = $Area2D

#endregion


func _ready() -> void:
	if Engine.is_editor_hint() :
		return
	SceneManager.new_scene_ready.connect( _on_new_scene_ready )
	SceneManager.load_scene_finished.connect( _on_load_scene_finished )
	
	pass


# Detect when player enters and transition to the next scene
func _on_player_entered( _n : Node2D) -> void :
	SceneManager.transition_scene( target_scene, target_area_name, get_offset( _n), "left" )
	pass


func _on_new_scene_ready( target_name : String, offset : Vector2 ) -> void :
	# Position player
	if target_name == name :
		var player : Node = get_tree().get_first_node_in_group( "Player" )
		player.global_position = global_position + offset
	pass


func _on_load_scene_finished() -> void :
	area.monitoring = false
	area.body_entered.connect( _on_player_entered )
	await get_tree().physics_frame
	await get_tree().physics_frame
	area.monitoring = true
	pass

# Update the size and location of the level transition area
func apply_area_settings() -> void :
	area = get_node_or_null( "Area2D" )
	if !area : 
		return
	if location == SIDE.LEFT or location == SIDE.RIGHT :
		area.scale.y = size
		if location == SIDE.LEFT :
			area.scale.x = -1
		else : 
			area.scale.x = 1
	else :
		area.scale.x = size
		if location == SIDE.UP :
			area.scale.y = 1
		else : 
			area.scale.y = -1
	pass

func get_offset( player : Node2D ) -> Vector2 :
	var offset : Vector2 = Vector2.ZERO
	var player_position : Vector2 = player.global_position
	
	#Calculate offset depending on the entrance (left, right, up, down)
	if location == SIDE.LEFT or location == SIDE.RIGHT :
		# Make it so that the player enters scene in the same area as they left the prev one. 
		offset.y = player_position.y - self.global_position.y
		
		if location == SIDE.LEFT : 
			offset.x = -12
		else : 
			offset.x = 12
	else : 
		offset.x = player_position.x - self.global_position.x
		if location == SIDE.UP : 
			offset.y = -2
		else : 
			offset.y = 48
	return offset
