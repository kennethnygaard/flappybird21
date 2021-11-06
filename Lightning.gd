extends Node2D

onready var main_timer = $"main lightning timer"
onready var cloud_timer = $"cloud lightning timer"
var rng = RandomNumberGenerator.new()
onready var thunderclap_audio = get_tree().get_nodes_in_group("thunderaudio")[0]

func _ready():
	main_timer.start(1)
	cloud_timer.start(0.5)
	rng.randomize()	
	
func _process(delta):
	pass

func set_paused(is_paused):
	if(is_paused):
		$"main lightning".set_speed_scale(0)
		$"main lightning2".set_speed_scale(0)
	else:
		$"main lightning".set_speed_scale(1)
		$"main lightning2".set_speed_scale(1)

func _on_main_lightning_timer_timeout():
	var number = randi() % 2 + 1
	if number==1:
		$"main lightning".emitting = true
	else:
		$"main lightning2".emitting = true
	var offset_x = rng.randi_range(-400, 400)
	$"main lightning".global_position.x += offset_x
	thunderclap_audio.play()

	var timeout = rng.randf_range(5.0, 10.0)
	main_timer.start(timeout)


func _on_cloud_lightning_timer_timeout():
	var number = randi() % 2 + 1
	if number==1:
		$"short lightning".emitting = false
	else:
		$"short lightning2".emitting = false

	thunderclap_audio.play()
	var timeout = rng.randf_range(5.0, 10.0)
	cloud_timer.start(timeout)
