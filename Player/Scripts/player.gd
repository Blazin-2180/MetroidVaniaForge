class_name Player extends CharacterBody2D

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

func _process ( _delta : float ) -> void:
	pass

func _physics_process ( _delta : float ) -> void:
	pass

func initialize_states () -> void :
	states = []
	# Gather all states
	for c in $States.get_children() :
		if c is PlayerState :
			states.append( c )
			c.player = self
		pass
	print ( states )
	
	#Initialise the states
	for state in states :
		state._init() 
	#Set first state
	pass
