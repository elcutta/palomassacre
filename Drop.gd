extends Node2D

const MAX_HEIGHT = 100
var height = MAX_HEIGHT
const FALLING_SPEED = 50
const SCALE_MAX = 1.1
const SCALE_MIN = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	height = height - (FALLING_SPEED * delta)
	var newScale = (height / MAX_HEIGHT) * (SCALE_MAX - SCALE_MIN) + SCALE_MIN
	$DropSprite.scale = Vector2(newScale, newScale)
	if (height <= 0):
		queue_free()
