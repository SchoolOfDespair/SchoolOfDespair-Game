class_name HUD extends Control


enum HUD_STATE { THREE_D, DIALOGUE }

var state: HUD_STATE = HUD_STATE.THREE_D

@onready var three_d_layer: CanvasLayer = %"3DLayer"
@onready var reticle: Reticle = %Reticle
@onready var focus_panel: Panel = %FocusTextPanel
@onready var focus_label: RichTextLabel = %FocusTextLabel


@onready var dialogue_layer: CanvasLayer = %DialogueLayer
@onready var dialogue_name: AutoSizeRichTextLabel = %NameLabel
@onready var dialogue_text: DialogueLabel = %DialogueLabel
@onready var dialogue_tooltip: TextureRect = %Tooltip


func unfocus():
	reticle.unfocus()
	
	focus_panel.visible = false

func focus(obj_name: String):
	reticle.focus()
	
	focus_label.text = obj_name
	focus_panel.visible = true


func change_to_3d():
	state = HUD_STATE.THREE_D
	three_d_layer.visible = true
	dialogue_layer.visible = false

func change_to_dialogue(char_name: String):
	state = HUD_STATE.THREE_D
	dialogue_layer.visible = true
	three_d_layer.visible = false
	dialogue_name.text = char_name


func _ready():
	unfocus()
	change_to_3d()
