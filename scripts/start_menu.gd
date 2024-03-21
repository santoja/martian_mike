extends Control

@onready var label: Label = $Label

@export var initial_color := Color.hex(0x93318bff)
@export var final_color := Color.hex(0x8c6f17ff)

var current_color_transition = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.label_settings.font_color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text_effect(delta)
		#label_3d.modulate = red.lerp(white, float(current_health) / float(max_health))

func text_effect(delta: float) -> void:
	current_color_transition += delta * 0.12
	if current_color_transition > 1:
		current_color_transition = 0
	label.label_settings.font_color = initial_color.lerp(final_color, current_color_transition)


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
