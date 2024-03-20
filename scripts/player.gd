extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var gravity := 400
@export var speed := 125
@export var jump_force := 200

func _physics_process(delta: float) -> void:
	if is_on_floor() == false :
		velocity.y += clamp(delta * gravity, 0, 500)
	
	if Input.is_action_just_pressed("jump"):
		velocity.y -= jump_force
		animated_sprite_2d.play("jump")
	
	velocity.x = Input.get_axis("move_left", "move_right") * speed
	move_and_slide()
