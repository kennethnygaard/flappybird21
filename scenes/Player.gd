extends KinematicBody2D

var gravity = 1200
var velocity = Vector2.ZERO
var jumpStrength = 600

enum State { GET_READY, PLAYING, DEAD, PAUSED }

var state = State.GET_READY

onready var main = get_tree().get_nodes_in_group("main")[0]

var is_paused:bool = false

signal start_game
signal disappeared_below
signal crashed

func _ready():
	reset()
	
func _process(delta):
	if(!is_paused):
		global_position += velocity*delta
		velocity.y += gravity*delta
	
	match state:
		State.GET_READY:
			process_get_ready(delta)
		State.PLAYING:
			process_playing(delta)
		State.DEAD:
			process_dead(delta)
		State.PAUSED:
			process_paused(delta)

func process_get_ready(delta):
	if(is_paused):
		return
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

func process_paused(delta):
	pass

func jump():
	velocity.y = velocity.y / 2 - jumpStrength
	$FlapAudioPlayer.play()

func die():
	jump()
	velocity.x = -300
	state = State.DEAD
	main.crash()
	

func reset():
	global_position = Vector2(300, 300)
	velocity.y = -500
	velocity.x = 0
	state = State.GET_READY

func set_paused(paused):
	is_paused = paused
	if(is_paused):
		$AnimatedSprite.stop()
	else:
		$AnimatedSprite.play()

func unpause():
	is_paused = false	
