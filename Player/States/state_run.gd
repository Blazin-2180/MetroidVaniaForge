class_name PlayerStateRun extends PlayerState

# What happens when the state is initialised ?
func _init() -> void:
	pass

# What happens when we enter the state ?
func enter() -> void :
	# Play animation
	pass

# What happens when we exit the state ?
func exit() -> void : 
	pass

# What happens when an input is pressed ?
func handle_input( _event : InputEvent ) -> PlayerState : 
	# Handle inputs besides movement
	return next_state

# What happens each process tick in this state ?
func process( _delta : float ) -> PlayerState :
	if player.direction.x == 0 :
		return idle
	return next_state

# What happens each physics process tick in this state ?
func physics_process( _delta : float ) -> PlayerState :
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
