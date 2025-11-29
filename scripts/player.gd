extends CharacterBody2D


@onready var animation_sp: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var score: Label = $Label

const SPEED = 220.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attacking = false

var death = false
var health = 100
var max_hel = 100
var min_hel = 0

var no = true
var BULLET = preload("res://scenes/arrow.tscn")

func _physics_process(delta: float) -> void:
	
	score.text = str(Global.score)
	
	if death:
		animation_sp.play("die")
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	if Input.is_action_just_pressed("attack"):
		is_attacking = true

	
	var direction := Input.get_axis("left", "right")
	
	if direction < 0:
		animation_sp.flip_h = true
		marker_2d.position.x = 1.0
	elif direction > 0:
		animation_sp.flip_h = false
		marker_2d.position.x = 11.0
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	
	if is_attacking:
		animation_sp.play("attack")
	
	elif direction != 0:
		animation_sp.play("walk")
	
	else:
		animation_sp.play("idle")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animation_sp.animation == "die":
		Global.score = 0
		get_tree().reload_current_scene()
		
	
	if animation_sp.animation == "attack":
		var bullet_ins = BULLET.instantiate()
		get_tree().root.add_child(bullet_ins)
		bullet_ins.global_position = marker_2d.global_position
		
		if animation_sp.flip_h == true:
			bullet_ins.dir = -1
		else:
			bullet_ins.dir = 1
		
		is_attacking = false
