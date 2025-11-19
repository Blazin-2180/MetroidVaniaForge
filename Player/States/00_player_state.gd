@icon( "res://Player/States/state.svg" )
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState


#region /// state references
@onready var idle : PlayerStateIdle = %Idle
@onready var run : PlayerStateRun = %Run
@onready var jump : PlayerStateJump = %Jump
@onready var fall : PlayerStateFall = %Fall
#endregion

# What happens when the state is initialised ?
func _init() -> void:
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
