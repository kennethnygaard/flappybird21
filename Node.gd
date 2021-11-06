extends Node

export(int) var numberToPlay = 1
export(bool) var enablePitchRandomization = true
export(float) var minPitchScale = 0.95
export(float) var maxPitchScale = 1.05

onready var normal_volume = $AudioStreamPlayer.volume_db

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()


func play():
	var validNodes = []
	for streamPlayer in get_children():
		if(!streamPlayer.playing):
			validNodes.append(streamPlayer)

	for i in range(numberToPlay):
		if (validNodes.size() == 0):
			break
		var idx = rng.randi_range(0, validNodes.size()-1)
		idx = 0
		if (enablePitchRandomization):
			validNodes[idx].pitch_scale = rng.randf_range(minPitchScale, maxPitchScale)
		
		validNodes[idx].play()
		validNodes.remove(idx)

func update_bus_volume(busName, volumePercent):
	var busIndex = AudioServer.get_bus_index(busName)
	var volumeDb = linear2db(volumePercent)
	AudioServer.set_bus_volume_db(busIndex, volumeDb)
