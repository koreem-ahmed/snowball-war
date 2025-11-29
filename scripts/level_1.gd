extends Node2D


func _on_wining_body_entered(body: Node2D) -> void:
	Transition.dissolve("res://scenes/winning.tscn")
