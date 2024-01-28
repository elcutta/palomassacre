extends Node2D

const PEDESTRIAN_BASE = preload("res://Pedestrian.tscn")
const PEDESTRIAN_QUANTITY = 12
const PEDESTRIAN_HEIGHT = 2

const NORMAL_POINTS = 10
const EXTRA_POINTS = 50
# When the pidgeon hits a person previously hitted
const SAME_PEDESTRIAN_MULTIPLIER = 2
# How much boreness is lowered by points
const POINTS_BORENESS_RATIO = 0.1

const MAX_DROP_DISTANCE = 10

var random = RandomNumberGenerator.new()

var score = 0
# How bored are the other pidgeons
var boreness = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for p_number in range(PEDESTRIAN_QUANTITY):
		var viewportSize = get_viewport_rect().size
		var randomX = random.randi_range(0, viewportSize.x)
		var randomY = random.randi_range(0, viewportSize.y)
		var randomPos = Vector2(randomX, randomY)
		putPedestrian(randomPos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# TODO: Raise boreness
	checkDrop()
	
func checkDrop():
	for pedestrian in get_tree().get_nodes_in_group("DropCatcher"):
		var pedestrianPos = pedestrian.global_position
		var viewportSize = get_viewport_rect().size
		var posChanged = false
		if pedestrianPos.x > viewportSize.x:
			pedestrianPos.x = 0
			posChanged = true
		elif pedestrianPos.x < 0:
			pedestrianPos.x = viewportSize.x
			posChanged = true
		if pedestrianPos.y > viewportSize.y:
			pedestrianPos.y = 0
			posChanged = true
		elif pedestrianPos.y < 0:
			pedestrianPos.y = viewportSize.y
			posChanged = true
			
		if posChanged:
			pedestrian.global_position = pedestrianPos
		
		for drop in get_tree().get_nodes_in_group("DropGroup"):
			if checkDropInPedestrian(drop, pedestrian):
				drop.queue_free()
				pedestrian.gotIt()
				# TODO: Show laughing pidgeons
				# TODO: Increase score
				# TODO: Decrease boreness

func checkDropInPedestrian(drop, pedestrian):
	var dropPos = drop.global_position
	var pedestrianPos = pedestrian.global_position
	var distance = dropPos.distance_to(pedestrianPos)
	return distance <= MAX_DROP_DISTANCE && drop.height <= PEDESTRIAN_HEIGHT

func putPedestrian(pedestrianPos):
	var pedestrian = PEDESTRIAN_BASE.instantiate()
	pedestrian.global_position = pedestrianPos
	add_child(pedestrian)
