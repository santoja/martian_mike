extends Node

const HURT = preload("res://assets/audio/hurt.wav")
const JUMP = preload("res://assets/audio/jump.wav")
const STREAMS = {'hurt': HURT, 'jump': JUMP}

func play_sfx(sfx_name: String) -> void:
	var asp = AudioStreamPlayer.new()
	asp.stream = STREAMS.get(sfx_name)
	add_child(asp)
	asp.play()
	await asp.finished
	asp.queue_free()
