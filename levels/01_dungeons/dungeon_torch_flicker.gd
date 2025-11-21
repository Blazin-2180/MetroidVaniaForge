extends PointLight2D


func _ready() -> void:
	flicker()
	pass 

func flicker() -> void :
	energy = randf() * 0.3 + 2
	scale = Vector2( 1, 1 ) * energy
	await get_tree().create_timer( 0.133 ).timeout
	flicker()
	pass
