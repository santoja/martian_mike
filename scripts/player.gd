extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var gravity := 400
@export var speed := 125
@export var jump_force := 200

var active = true

func _physics_process(delta: float) -> void:
	if !active:
		return
	var direction = Input.get_axis("move_left", "move_right")
	if is_on_floor():
		player_on_the_floor(direction)
	else:
		player_in_the_air(delta)

	velocity.x =  direction * speed
	
	move_and_slide()

func player_on_the_floor(direction: int) -> void:
	if Input.is_action_just_pressed("jump"):
		jump(jump_force)
		animated_sprite_2d.play("jump")
	
	update_animation_floor(direction)
	
func player_in_the_air(delta: float) -> void:
	fall(delta)
	update_animation_air()

func update_animation_air() -> void:
	if velocity.y < 0:
		animated_sprite_2d.play("jump")
	else: 
		animated_sprite_2d.play("fall")
	
func update_animation_floor(direction: int) -> void:
	if direction == 0:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.flip_h = (direction == -1)
		animated_sprite_2d.play("run")

func fall(delta) -> void:
	velocity.y += clamp(delta * gravity, 0, 500)
	
func stop() -> void:
	velocity = Vector2.ZERO
	
func jump(force):
	AudioPlayer.play_sfx("jump")
	velocity.y = -force
