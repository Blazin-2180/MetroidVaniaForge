class_name Player extends CharacterBody2D

#region /// Export Variables
@export var move_speed : float = 150
#endregion

#region /// State Machine Variables
var states : Array[ PlayerState ]

var current_state : PlayerState : 
	get : return states.front()
	
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// Standard Variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
#endregion

func _ready () -> void:
	initialize_states()
	pass

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	pass
	
func _process ( _delta : float ) -> void:
	update_direction()
	change_state( current_state.process(_delta) )
	pass

func _physics_process ( _delta : float ) -> void:
	velocity.y += gravity * _delta 
	move_and_slide()
	change_state( current_state.physics_process(_delta) )
	pass

func initialize_states () -> void :
	states = []
	# Gather all states
	for c in $States.get_children() :
		if c is PlayerState :
			states.append( c )
			c.player = self
		pass
	# Fail safe for if there are no states to call
	if states.size() == 0 :
		return
	#Initialise the states
	for state in states :
		state._init() 
	#Set first state
	change_state( current_state )
	current_state.enter()
	$Label.text = current_state.name
	pass

func change_state (new_state : PlayerState) -> void :
	# Check if state is a valid state
	if new_state == null :
		return
	# Check if new state is the same as the current state 
	elif new_state == current_state :
		return
	if current_state :
		current_state.exit()
	# Make new state the first item in the array
	states.push_front( new_state )
	current_state.enter()
	# Only keep the last three states
	states.resize( 3 )
	$Label.text = current_state.name
	pass
	
func update_direction() -> void :
	#var previous_direction : Vector2 = direction
	var x_axis = Input.get_axis( "left", "right" )
	var y_axis = Input.get_axis( "up", "down" )
	direction = Vector2( x_axis, y_axis )
	# Do more stuff, lol
	pass
