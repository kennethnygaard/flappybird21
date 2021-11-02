extends Camera2D

export(OpenSimplexNoise) var shakeNoise

var xNoiseSampleVector = Vector2.RIGHT
var yNoiseSamleVector = Vector2.DOWN
var xNoiseSamplePosition = Vector2.ZERO
var yNoiseSamplePosition = Vector2.ZERO

var noiseSampleTravelRate = 1000
var maxShakeOffset = 50
var currentShakePercentage = 0
var shakeDecay = 1

func _ready():
	#apply_shake(1)
	pass

func _process(delta):
	if(currentShakePercentage > 0):
		xNoiseSamplePosition += xNoiseSampleVector * noiseSampleTravelRate * delta
		yNoiseSamplePosition += xNoiseSampleVector * noiseSampleTravelRate * delta
		var xSample = shakeNoise.get_noise_2d(xNoiseSamplePosition.x, xNoiseSamplePosition.y)
		var ySample = shakeNoise.get_noise_2d(yNoiseSamplePosition.x, yNoiseSamplePosition.y)

		var calculatedOffset = Vector2(xSample, ySample) * maxShakeOffset * pow(currentShakePercentage, 4)
		offset = Vector2(calculatedOffset.x+512, calculatedOffset.y + 300)
		
		currentShakePercentage = clamp(currentShakePercentage-shakeDecay*delta, 0, 1)


func apply_shake(percentage):
	currentShakePercentage = clamp(currentShakePercentage + percentage, 0, 1)
