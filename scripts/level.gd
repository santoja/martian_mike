extends Node2D

@export var next_level: PackedScene
@export var level_max_time := 60
@export var is_final_level := false

@onready var start: StartPosition = $Start
@onready var exit: Exit = $Exit
@onready var deathzone: Area2D = $Deathzone
@onready var hud = $UILayer/HUD
@onready var ui_layer: UiLayer = $UILayer



var player: Player
var timer_node: Timer
var time_left: int
var win := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.global_position = start.global_position
	connect_traps()
	connect_exit()
	connect_deathzone()
	start_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	


func _on_deathzone_body_entered(_body: Node2D) -> void:
	player_fell()


func player_fell() -> void:
	player_died()

func player_died() -> void:
	AudioPlayer.play_sfx("hurt")
	player.global_position = start.global_position
	player.stop()


func _on_trap_touched_player() -> void:
	player_died()

func connect_traps() -> void:
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)

func connect_exit() -> void:
	exit.body_entered.connect(_on_exit_body_entered)

func _on_exit_body_entered(body) -> void:
	win = true
	if !(body is Player):
		return 
	if !next_level  && !is_final_level:
		return
	
	exit.animate()
	player.active = false
	await get_tree().create_timer(2).timeout
	if is_final_level:
		ui_layer.show_win_screen(true)
	else:
		get_tree().change_scene_to_packed(next_level)
	
	
func connect_deathzone() -> void:
	deathzone.body_entered.connect(_on_deathzone_body_entered)

func start_timer() -> void:
	time_left = level_max_time
	hud.set_time_label(time_left)
	timer_node = Timer.new()
	timer_node.name = "level_timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_one_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()
	
func _one_level_timer_timeout() -> void:
	if win:
		return
	
	time_left -= 1
	if time_left < 0:
		player_died()
		time_left = level_max_time
	hud.set_time_label(time_left)
