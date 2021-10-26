extends CanvasLayer

onready var continueButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ContinueButton
onready var quitButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton

var is_paused:bool = false
onready var main = get_tree().get_nodes_in_group("main")[0]
	
func _ready():
	continueButton.connect("pressed", self, "on_continue_pressed")
	quitButton.connect("pressed", self, "on_quit_pressed")
	
	main.connect("paused", self, "on_paused")
	
	$MarginContainer.set_visible(false)

func _process(delta):
	pass
	
func on_continue_pressed():
	is_paused = false
	main.is_paused = false
	main.set_paused(is_paused)
	$MarginContainer.set_visible(is_paused)
	
	
func on_quit_pressed():
	get_tree().quit()

func on_paused(paused):
	is_paused = !is_paused
	$MarginContainer.set_visible(is_paused)

