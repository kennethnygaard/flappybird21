extends Node

var backgroundSprite = preload("res://scenes/BackgroundSprite.tscn")
var pipe = preload("res://scenes/Pipe.tscn")
var smoke = preload("res://scenes/Smoke.tscn")

var screen_width = 1024
var screen_height = 600
var points = 0
var bs = []
var pipes = []

onready var points_counter = $PointsCounter
onready var player = $PlayerRoot/Player
onready var restartMenu = $RestartMenu
onready var ready = $Ready


func _ready():
	setup_background()
	setup_pipes()
	restartMenu.set_visible(false)
	player.connect("disappeared_below", self, "show_restart_menu")
	restartMenu.connect("restart", self, "restart")
	player.connect("crashed", self, "on_crashed")
	
	#var smoke1 = smoke.instance()
	#smoke1.global_position.x = 0
	#smoke1.z_index = 2
	
	#print(smoke1)

func _process(delta):

	$Smoke.global_position.x -= 300*delta
	if($Smoke.global_position.x < -100):
		$Smoke.global_position.x = 1100
	pass

func setup_background():
	for i in range(5):
		bs.append(backgroundSprite.instance())
		bs[i].set_pos(i)
		add_child(bs[i])

func setup_pipes():
	for i in range(3):
		pipes.append(pipe.instance())
		add_child(pipes[i])
		pipes[i].connect("point_collected", self, "on_point_collected")
		pipes[i].connect("crashed", self, "on_crashed")	
	reset_pipes()

func on_point_collected():
	points+=1
	points_counter.set_points(points)

func on_crashed():
	for i in range(3):
		pipes[i].stop_scrolling()
	player.die()

func show_restart_menu():
	restartMenu.set_visible(true)	

func reset_pipes():
	for i in range(3):
		pipes[i].set_x(300 + screen_width + 1500/3*i)
		pipes[i].stop_scrolling()

func restart():
	points = 0
	points_counter.set_points(points)
	reset_pipes()
	player.reset()
	ready.set_visible(true)
	restartMenu.set_visible(false)
