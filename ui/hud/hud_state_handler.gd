class_name UIManager extends Node

@export var threed_explore_layer: CanvasLayer
@export var conversation_layer: CanvasLayer

@export var player: Player3D

@export var unfocused_reticle_container: BoxContainer
@export var focused_reticle_container: BoxContainer
@export var focused_name_container: BoxContainer

@export var focused_name: RichTextLabel

@export var conversation_name: RichTextLabel

func unfocus():
	unfocused_reticle_container.visible = true
	focused_reticle_container.visible = false
	focused_name_container.visible = false

func focus(charname: String):
	unfocused_reticle_container.visible = false
	focused_reticle_container.visible = true
	focused_name_container.visible = true
	
	focused_name.text = charname
	
func change_to_3d():
	threed_explore_layer.visible = true
	conversation_layer.visible = false
	player.movement_locked = false
	
func change_to_conversation():
	threed_explore_layer.visible = false
	conversation_layer.visible = true
	player.movement_locked = true
	
func conversation_change_name(char_name: String):
	conversation_name.text = char_name
	
func _ready():
	change_to_3d()
	
