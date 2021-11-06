extends Node2D

signal toggle_sound(is_on)

var icon_on = preload("res://assets/sound_on.png")
var icon_off = preload("res://assets/sound_off.png")
var is_on:bool = true


func _ready():
	$CanvasLayer/Button.connect("pressed", self, "on_pressed")
	pass
	
func on_pressed():
	is_on = !is_on
	if(is_on):
		$CanvasLayer/Button.set_button_icon(icon_on)
	else:
		$CanvasLayer/Button.set_button_icon(icon_off)
	emit_signal("toggle_sound", is_on)

	

