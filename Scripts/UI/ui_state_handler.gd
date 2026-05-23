extends Node
class_name UIManager

@export var unfocused_reticle_container: BoxContainer
@export var focused_reticle_container: BoxContainer
@export var focused_name_container: BoxContainer

@export var focused_name: RichTextLabel

func unfocus():
	unfocused_reticle_container.visible = true
	focused_reticle_container.visible = false
	focused_name_container.visible = false

func focus(charname: String):
	unfocused_reticle_container.visible = false
	focused_reticle_container.visible = true
	focused_name_container.visible = true
	
	focused_name.text = charname
