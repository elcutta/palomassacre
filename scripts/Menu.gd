extends Control

func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://maingame.tscn")

func _on_salir_pressed():
	get_tree().quit()

func _on_salir_mouse_entered():
	$sfx.play()

func _on_jugar_mouse_entered():
	$sfx.play()
