@icon( "res://player/states/state.svg" )
class_name PlayerState extends Node

#region /// state references
## STATE REFERENCES ##
@onready var idle : PlayerStateIdle = %Idle
@onready var run : PlayerStateRun = %Run
@onready var jump : PlayerStateJump = %Jump
@onready var fall : PlayerStateFall = %Fall
@onready var crouch : PlayerStateCrouch = %Crouch

## STANDARD VARIABLES ##
var player : Player
var next_state : PlayerState
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
