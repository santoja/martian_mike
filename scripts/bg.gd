extends ParallaxBackground

@onready var sprite_2d: Sprite2D = $ParallaxLayer/Sprite2D

@export var scroll_speed := 15
@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/Purple.png")

func _ready() -> void:
	sprite_2d.texture = bg_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite_2d.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	if sprite_2d.region_rect.position >= Vector2(64, 64):
		sprite_2d.region_rect.position = Vector2.ZERO
