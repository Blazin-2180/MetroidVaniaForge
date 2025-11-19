class_name PlayerStateJump extends PlayerState

#region /// 

## EXPORT VARIABLES ##
@export var jump_velocity : float = 450.0

#endregion


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func enter() -> void :
	#play animation
	player.animation_player.play( "jump" )
	player.animation_player.pause()
	#player.add_debug_indicator( Color.WEB_GREEN )
	player.velocity.y = -jump_velocity
	
	#Check if this is a buffer jump
	#If it is, handle jump button release retroactively
	if player.previous_state == fall && not Input.is_action_pressed( "jump" ) :
		await get_tree().physics_frame
		player.velocity.y *= 0.5
		player.change_state( fall )
		pass
	pass


func exit() -> void : 
	#player.add_debug_indicator( Color.YELLOW )
	pass


func handle_input( _event : InputEvent ) -> PlayerState :
	#variable jump height
	if _event.is_action_released("jump") :
		player.velocity.y *= 0.5
		return fall
	return next_state


func physics_process( _delta : float ) -> PlayerState :
	#check whether player is on the floor
	if player.is_on_floor() :
		return idle
		#check whether player is falling
	elif player.velocity.y >= 0 :
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process( _delta : float ) -> PlayerState:
		set_jump_frame()
		return next_state


func set_jump_frame() -> void :
	var frame : float = remap( player.velocity.y, -jump_velocity,  0.0, 0.0, 0.5 )
	player.animation_player.seek( frame, true )
	pass
