extends Sprite

var width = get_rect().size.x
var scrollSpeed = 50
var is_paused:bool = false
var scrolling = true

func _ready():
	pass # Replace with function body.

func _process(delta):
	if(is_paused or !scrolling):
		return
	global_position.x -= scrollSpeed*delta
	if(global_position.x < -400):
		global_position.x += width*5*scale.x-2
	
func set_pos(x_pos):
	global_position.x = get_rect().size.x*scale.x*x_pos

func set_paused(paused):
	is_paused = paused
