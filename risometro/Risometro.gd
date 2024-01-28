extends Control

@export_category("Configuration")
@export_range(0.1, 10.0, 0.1) var loop_delta_time : float
@export_range(0.1, 50.0, 0.1) var loop_delta_points : float
@export_range(0.1, 200.0, 0.1) var max_points : float
@export_range(0.1, 200.0, 0.1) var current_points : float
@export_range(0.1, 50.0, 0.1) var points_per_hit : float
@export_range(0.1, 10.0, 0.1) var laugh_time : float

@export_category("Dependencies")
@export var progress_bar : ProgressBar
@export var loop_timer : Timer
@export var laugh_timer : Timer
@export var label : Label
@export var pidgeons : TextureRect
@export var img_risa : Texture2D
@export var img_indif : Texture2D

signal bored_signal
signal joyful_signal

const label_prefix : String = "          "

func _ready() -> void:
	pidgeons.texture = img_indif
	loop_timer.start(loop_delta_time)
	progress_bar.max_value = max_points
	progress_bar.value = current_points

func  _process(_delta: float) -> void:
	if current_points < 0.0:
		current_points = 0.0
	
	elif current_points <= 0.0:
		bored_signal.emit()
	
	elif current_points >= max_points:
		joyful_signal.emit()
	
	label.text = label_prefix + str(int(current_points)) + "pt"
	progress_bar.value = current_points

func add_points() -> void:
	pidgeons.texture = img_risa
	laugh_timer.start(laugh_time)
	loop_timer.start(laugh_time)
	current_points += points_per_hit

func _on_loop_timer_timeout() -> void:
	current_points -= loop_delta_points

func _on_laugh_timer_timeout() -> void:
	loop_timer.start(loop_delta_time)
	pidgeons.texture = img_indif

func _on_button_button_down() -> void:
	add_points()
