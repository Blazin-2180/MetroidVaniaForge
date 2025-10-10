@icon( "res://Player/States/state.svg" )
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region /// state references
# Will contain a reference to all other states
#endregion

# What happens when the state is initialised ?
func _init() -> void:
	print("init : ", name)
	pass

# What happens when we enter the state ?
func enter() -> void : 
	pass

# What happens when we exit the state ?
func exit() -> void : 
	pass

# What happens when an input is pressed ?
func handle_input( _event : InputEvent ) -> PlayerState : 
	return next_state

# What happens each process tick in this state ?
func process( _delta : float ) -> PlayerState :
	return next_state

# What happens each physics process tick in this state ?
func physics_process( _delta : float ) -> PlayerState :
	return next_state
