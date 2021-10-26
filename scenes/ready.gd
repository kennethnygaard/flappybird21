extends Node2D

func _ready():
	var player = get_tree().get_nodes_in_group("player")[0]
	player.connect("start_game", self, "on_start_game")
	
func on_start_game():
	visible = false

