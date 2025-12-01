class_name LightFlicker extends PointLight2D

#region

## EXPORT VARIABLES ##
@export var flicker_intensity : float = 0.1
@export var flicker_frequency : float = 0.2

## STANDARD VARIABLES ##
var original_energy : float = 1.0

#endregion


func _ready() -> void:
	original_energy = energy
	flicker()
	pass 


func flicker() -> void :
	var new_value : float = randf_range( -1, 1 ) * flicker_intensity
	energy = original_energy + new_value
	scale = Vector2 ( 1, 1 ) * original_energy 
	await get_tree().create_timer( 
		flicker_frequency + 
		randf_range( flicker_frequency * -0.3, flicker_frequency * 0.3) 
		).timeout
	flicker()
	pass
