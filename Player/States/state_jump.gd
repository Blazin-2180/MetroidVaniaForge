class_name PlayerStateJump extends PlayerState

#region /// 
@export var jump_velocity : float = 450.0
#endregion


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func enter() -> void :
	#play animation
	player.add_debug_indicator( Color.WEB_GREEN )
	player.velocity.y = -jump_velocity
	pass


func exit() -> void : 
	player.add_debug_indicator( Color.YELLOW )
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
func _process( _delta : float ) -> void:
	pass
