extends Node2D

var scrollSpeed = 300
var rng = RandomNumberGenerator.new()

var scrolling = false

signal point_collected
signal crashed

onready var pointsArea = $Area2D
onready var collisionArea = $Pipes_area

func _ready():
	#x=700
	#global_position.x = 1000
	global_position.y = 300
	scale = Vector2(0.4, 0.4)
	pointsArea.connect("area_entered", self, "on_points_area_entered")
	collisionArea.connect("area_entered", self, "on_crashed")
	rng.randomize()
	
	var player = get_tree().get_nodes_in_group("player")[0]

	player.connect("start_game", self, "on_start_game")

func _process(delta):
	if(scrolling):
		global_position.x -= scrollSpeed*delta
	if(global_position.x < -100):
		reset_position()

func on_points_area_entered(area2d):
	emit_signal("point_collected")

func on_crashed(area2d):
	emit_signal("crashed")

func reset_position():
	var min_pipe_y = 200
	var max_pipe_y = 450
	
	global_position.x += 1600
	global_position.y = rng.randi_range(min_pipe_y, max_pipe_y)

func set_x(x):
	global_position.x = x

func on_start_game():
	scrolling = true

func stop_scrolling():
	scrolling = false
	
func start_scrolling():
	scrolling = true
