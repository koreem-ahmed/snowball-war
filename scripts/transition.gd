extends Node2D

@onready var animation: AnimationPlayer = $animation


func dissolve(target) -> void:
	animation.play("dissolve")
	get_tree().change_scene_to_file(target)
	animation.play_backwards("dissolve")
