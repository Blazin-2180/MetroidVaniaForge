class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate : float = 10.0


# What happens when the state is initialised ?
func init() -> void:
	pass


# What happens when we enter the state ?
func enter() -> void :
	#Play animation
	player.animation_player.play( "crouch" )
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	pass


# What happens when we exit the state ?
func exit() -> void : 
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	pass


# What happens when an input is pressed ?
func handle_input( _event : InputEvent ) -> PlayerState : 
	if _event.is_action_pressed("jump") :
		player.one_way_platform_shapecast.force_shapecast_update()
		if player.one_way_platform_shapecast.is_colliding() :
			player.position.y += 4
			return fall
		return jump
	return next_state


# What happens each process tick in this state ?
func process( _delta : float ) -> PlayerState :
	if player.direction.y <= 0.5 :
		return idle
	return next_state


# What happens each physics process tick in this state ?
func physics_process( _delta : float ) -> PlayerState :
	#adjust player velocity when going from running to crouch
	player.velocity.x -= player.velocity.x * deceleration_rate * _delta
	#enter fall state
	if player.is_on_floor() == false :
		return fall
	return next_state
