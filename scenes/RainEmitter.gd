extends Node2D

var is_paused:bool = false

onready var speed_scale = $Particles2D.get_speed_scale()

func _ready():
	pass
	
func set_paused(paused):
	is_paused = paused
	if(is_paused):
		$Particles2D.set_speed_scale(0)
	else:
		$Particles2D.set_speed_scale(speed_scale)
