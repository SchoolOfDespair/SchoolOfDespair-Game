class_name Reticle extends CenterContainer


@export var sprite: TextureRect

@export var unfocused_texture: Texture2D
@export var focused_texture: Texture2D


func _ready() -> void:
	sprite.texture = unfocused_texture

func _process(delta: float) -> void:
	sprite.rotation += 1 * delta


func focus() -> void:
	sprite.texture = focused_texture

func unfocus() -> void:
	sprite.texture = unfocused_texture
