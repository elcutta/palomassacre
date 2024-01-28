extends CharacterBody2D

var random = RandomNumberGenerator.new()
var vectorDir

# Times the pedestrian got the drop
var timesGotIt = 0
# Time the pedestrian gets to complain
var complaining = 0

const MIN_SPEED = 5.0
const MAX_SPEED = 40.0
# Complaining time in ms
const TIME_COMPLAIN = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	var dir = random.randi_range(0, 3)
	var rotationDegs = 0
	match dir:
		0:
			vectorDir = Vector2(1, 0)
			rotationDegs = 270
		1:
			vectorDir = Vector2(0, 1)
		2:
			vectorDir = Vector2(-1, 0)
			rotationDegs = 90
		3:
			vectorDir = Vector2(0, -1)
			rotationDegs = 180
	
	vectorDir = vectorDir * random.randf_range(MIN_SPEED, MAX_SPEED)
	global_rotation_degrees = rotationDegs

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if complaining > 0:
		$AnimatedSprite2D.pause()
		complaining -= delta
		if complaining < 0:
			complaining = 0
			playRant()
			$AnimatedSprite2D.play()
	else:
		velocity = vectorDir * (timesGotIt + 1)
		move_and_slide()

func gotIt():
	timesGotIt += 1
	complaining = TIME_COMPLAIN
	
func playSplat():
	$SplatPlayer.play()

func playRant():
	$RantPlayer.play()
