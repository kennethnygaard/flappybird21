extends Node2D

onready var emit_speed = $Particles2D.get_speed_scale()

var is_paused:bool = false

func _ready():
	pass # Replace with function body.

func set_paused(paused):
	is_paused = paused
	
	if(is_paused):
		$Particles2D.set_speed_scale(0)
	else:
		$Particles2D.set_speed_scale(emit_speed)

