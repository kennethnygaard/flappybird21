extends KinematicBody2D

var gravity = 1200
var velocity = Vector2.ZERO
var jumpStrength = 600

enum State { GET_READY, PLAYING, DEAD }

var state = State.GET_READY

signal start_game
signal disappeared_below
signal crashed

func _ready():
	reset()
	
func _process(delta):
	global_position += velocity*delta
	velocity.y += gravity*delta
	
	match state:
		State.GET_READY:
			process_get_ready(delta)
		State.PLAYING:
			process_playing(delta)
		State.DEAD:
			process_dead(delta)

func process_get_ready(delta):
	if(global_position.y > 300):
		velocity.y = -jumpStrength*0.75
	if(Input.is_action_just_pressed("jump")):
		state = State.PLAYING
		emit_signal("start_game")
		if(velocity.y > 0):
			jump()

func process_playing(delta):	
	if(Input.is_action_just_pressed("jump")):
		jump()
	global_position.y = clamp(global_position.y, 0, 1000)
	velocity.y = clamp(velocity.y, -10000, 2000)
	if(global_position.y > 600):
		die()
		emit_signal("crashed")

func process_dead(delta):
	if(global_position.y > 1000):
		emit_signal("disappeared_below")

func jump():
	velocity.y = velocity.y / 2 - jumpStrength

func die():
	jump()
	velocity.x = -300
	state = State.DEAD	

func reset():
	global_position = Vector2(300, 300)
	velocity.y = -500
	velocity.x = 0
	state = State.GET_READY
