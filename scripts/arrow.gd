extends Node2D

@onready var bullet: Sprite2D = $arrow_png


var speed = 300
var dir = 1


func _physics_process(delta: float) -> void:
	if dir < 0:
		bullet.flip_h = true
	elif dir > 0:
		bullet.flip_h = false
	
	position.x += dir * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_hit_area_body_entered(body: Node2D) -> void:
	body.health -= 40
	queue_free()
