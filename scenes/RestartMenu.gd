extends CanvasLayer

signal restart

func _ready():
	var restartButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/RestartButton
	var quitButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton

	restartButton.connect("pressed", self, "on_restart_pressed")
	quitButton.connect("pressed", self, "on_quit_pressed")

func on_restart_pressed():
	emit_signal("restart")

func on_quit_pressed():
	get_tree().quit()

func set_visible(visible):
	$MarginContainer.visible = visible
