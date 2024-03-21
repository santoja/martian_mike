extends Node2D

signal touched_player

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export_range(0, 1) var moviment_speed: float = 1

func _ready() -> void:
	set_movement_speed(moviment_speed) 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		touched_player.emit()

func set_movement_speed(speed: float) -> void:
	animation_player.speed_scale = speed
