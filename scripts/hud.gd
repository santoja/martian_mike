extends Control

@onready var time_label: Label = $TimeLabel

func set_time_label(time: int) -> void:
	time_label.text = "TIME: " + str(time)
