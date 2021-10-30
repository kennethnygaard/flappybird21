extends Node2D

#onready var emit_speed = $Particles2D.get_speed_scale()
onready var fire = preload("res://scenes/Fire.tscn")

var is_paused:bool = false

var fires = []
var is_scrolling:bool = true
var new_fire_countdown
var produce_fires = true


var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	add_fire()
	new_fire_countdown = rng.randi_range(2, 10)

func _process(delta):
	for i in range(fires.size()):
		if(fires[i] && is_scrolling):
			fires[i].global_position.x -= 300*delta	

	if(produce_fires):
		new_fire_countdown -= 1
		if(new_fire_countdown < 0):
			add_fire()
			new_fire_countdown = rng.randi_range(2, 10)	

func set_paused(paused):
	is_paused = paused
	var speed_multiplier		
	if(is_paused):
		#set_scrolling(false)
		speed_multiplier = 0
	else:
		#set_scrolling(true)
		speed_multiplier = 1
		
		#$Particles2D.set_speed_scale(emit_speed)
	for i in range(0, fires.size()):
		fires[i].set_speed_scale(fires[i].emit_speed * speed_multiplier)
	
func set_scrolling(scrolling):
	is_scrolling = scrolling


func add_fire():
	var newfire = fires.append(fire.instance())
	var index = fires.size()-1
	add_child(fires[index])
	fires[index].connect("fire_disappeared", self, "on_fire_disappeared")
	fires[index].id = index	

func on_fire_disappeared(id):
	#fires.remove(id)
	#add_fire()
	produce_fires = false
