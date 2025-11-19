class_name PlayerStateIdle extends PlayerState

# Enter Jump State


# What happens when the state is initialised ?
func _init() -> void:
	pass


# What happens when we enter the state ?
func enter() -> void :
	#Play animation
	pass


# What happens when we exit the state ?
func exit() -> void : 
	pass


# What happens when an input is pressed ?
func handle_input( _event : InputEvent ) -> PlayerState : 
	# Handle inputs besides moving
	if _event.is_action_pressed("jump") :
		return jump
	return next_state


# What happens each process tick in this state ?
func process( _delta : float ) -> PlayerState :
	if player.direction.x != 0 :
		return run
	return next_state


# What happens each physics process tick in this state ?
func physics_process( _delta : float ) -> PlayerState :
	player.velocity.x = 0
	if player.is_on_floor() == false :
		return fall
	return next_state
