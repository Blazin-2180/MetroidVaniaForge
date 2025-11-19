class_name PlayerStateFall extends PlayerState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process( _delta : float ) -> PlayerState:
	return next_state
	
	
func physics_process( _delta : float ) -> PlayerState :
	#check whether player is on the floor
	if player.is_on_floor() :
		player.add_debug_indicator()
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
