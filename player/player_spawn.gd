@icon ("res://general/icons/player_spawn.svg")
class_name PlayerSpawn extends Node2D

func _ready() -> void:
	visible = false
	await get_tree().process_frame
	
	if get_tree().get_first_node_in_group("Player") :
		#Check for player
		#Player present
		print("player found")
		return
		#If we have a player, do nothing
	print("player not found")

	#If we do not find player, instantiate one
	var player : Player = load("uid://21wgui61a3l4").instantiate()
	get_tree().root.add_child( player )
	
	#Position player scene in the level
	player.global_position = self.global_position
	pass
