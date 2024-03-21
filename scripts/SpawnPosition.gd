extends StaticBody2D

class_name StartPosition

@onready var spawn_position: Marker2D = $SpawnPosition

func get_spawn_pos() -> Vector2:
	return spawn_position.global_position

