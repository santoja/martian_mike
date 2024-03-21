extends Area2D

class_name Exit

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func animate() -> void:
	animated_sprite_2d.play("default")
