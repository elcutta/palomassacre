extends Node2D

var height = 100
const FALLING_SPEED = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	height = height - (FALLING_SPEED * delta)
	if (height <= 0):
		queue_free()
