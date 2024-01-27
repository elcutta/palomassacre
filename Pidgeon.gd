extends CharacterBody2D

const DROP = preload("res://Drop.tscn")

const MOVEMENT_OFFSET = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * MOVEMENT_OFFSET
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot"):
		var drop = DROP.instantiate()
		drop.global_position = global_position
		get_parent().add_child(drop)
