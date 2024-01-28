extends Control

@export_category("Configuration")
@export_range(1.0, 10.0, 0.1) var loop_delta_time : float
@export_range(1.0, 50.0, 0.1) var loop_delta_points : float
@export_range(1.0, 200.0, 0.1) var max_points : float
@export_range(1.0, 200.0, 0.1) var current_points : float
@export_range(1.0, 50.0, 0.1) var points_per_hit : float

@export_category("Dependencies")
@export var progress_bar : ProgressBar
@export var timer : Timer

signal bored_signal
signal joyful_signal

func _ready() -> void:
	timer.wait_time = loop_delta_time
	progress_bar.max_value = max_points
	progress_bar.value = current_points

func  _process(_delta: float) -> void:
	if current_points < 0.0:
		current_points = 0.0

	elif current_points <= 0.0:
		bored_signal.emit()

	elif current_points >= max_points:
		joyful_signal.emit()

	progress_bar.value = current_points

func add_points() -> void:
	current_points += points_per_hit

func _on_timer_timeout() -> void:
	current_points -= loop_delta_points
