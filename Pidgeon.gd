extends CharacterBody2D

const DROP = preload("res://Drop.tscn")

var waitToShoot = 0
const TIME_BETWEEN_DROPS = 1.5
const MOVEMENT_OFFSET = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if !input_direction.is_zero_approx():
		velocity = input_direction * MOVEMENT_OFFSET
		global_rotation = input_direction.angle()
		move_and_slide()
		
		var posX = global_position.x
		var posY = global_position.y
		var change = false
		if posX < 0:
			posX = 0
			change = true
		elif posX > get_viewport_rect().size.x:
			posX = get_viewport_rect().size.x
			change = true
		if posY < 0:
			posY = 0
			change = true
		elif posY > get_viewport_rect().size.y:
			posY = get_viewport_rect().size.y
			change = true
		
		if change:
			global_position = Vector2(posX, posY)
	
	if waitToShoot > 0:
		waitToShoot -= delta
		if waitToShoot < 0:
			waitToShoot = 0
	elif Input.is_action_just_pressed("shoot"):
		var drop = DROP.instantiate()
		drop.global_position = global_position
		get_parent().add_child(drop)
		waitToShoot = TIME_BETWEEN_DROPS
