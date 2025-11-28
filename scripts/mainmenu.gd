extends Node2D


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	Transition.dissolve("res://scenes/level_1.tscn")
