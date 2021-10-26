extends CanvasLayer



func _ready():
	pass # Replace with function body.

func set_points(points):
	$MarginContainer/PanelContainer/HBoxContainer/Label.text = str("Points: ", points)
