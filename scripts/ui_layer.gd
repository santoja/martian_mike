extends CanvasLayer

class_name UiLayer

@onready var win_screen: Control = $WinScreen

func show_win_screen(flag: bool):
	win_screen.visible = flag
