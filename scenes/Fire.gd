extends Particles2D

signal fire_disappeared(id)

var id=0
var rng = RandomNumberGenerator.new()
var emit_speed
	
func _ready():
	rng.randomize()
	var x = 1200 + rng.randi_range(0, 200)
	var y = 600 + rng.randi_range(0,100)
	global_position = Vector2(x, y)
	preprocess = rng.randf_range(1, 1.5)
	lifetime = rng.randf_range(1.3, 1.8)
	emit_speed = get_speed_scale()

func _process(_delta):
	if(global_position.x < -100):
		emit_signal("fire_disappeared", id)
		var new_x = 1200 + rng.randi_range(0, 100)
		var new_y = 600 + rng.randi_range(0, 100)
		global_position = Vector2(new_x, new_y)
