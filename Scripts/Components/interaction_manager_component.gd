class_name InteractionManager extends Node

# mkay i can't be arsed to make this right now but
# essentially, this is what tells the UI what we interacted with and what we can interact with by using either raycasting a few units infront or
# it uses a collider as a trigger (at least that's what it's called in Unity), to see what we're looking at, to which the UI can update, showing
# the reticle and the information box telling the player what they're looking at, most likely a character
@export var player: ThreeDPlayer

@export var area3d: Area3D

@export var ui_manager: UIManager

@export var dialog: DialogueLabel

var in_conversation = false

var current_focused_object: ThreeDCharacter

func _ready() -> void:
	area3d.body_entered.connect(_on_area_entered)
	area3d.body_exited.connect(_on_area_exited)
	print("Interaction Manager Ready")
	ui_manager.unfocus()

func _on_area_entered(obj: ThreeDCharacter):
	if (obj.character_name):
		print(obj.name)
		print("^ entered")
		current_focused_object = obj
		ui_manager.focus(obj.character_name)

func _on_area_exited(obj: ThreeDCharacter):
	if (obj.character_name):
		print(obj.name)
		print("^ exited")
		ui_manager.unfocus()
		current_focused_object = null

func interact():
	if (in_conversation):
		if (current_focused_object.has_one_line):
			if (dialog._display_stage == DialogueLabel.DISPLAY_STAGE.DISPLAYING):
				return
			else:
				ui_manager.change_to_3d()
				in_conversation = false
		else:
			ui_manager.change_to_3d()
			in_conversation = false # stub code, needs to be changed for full conversations later
		return
	
	print("interacted")
	Input.start_joy_vibration(0, 1, 1, 1)
	# todo
	
	if (current_focused_object):
		ui_manager.change_to_conversation()
		in_conversation = true
		if (current_focused_object.has_one_line):
			dialog.display_text(current_focused_object.one_line)
		else:
			print("Conversation code missing")
			# needs finishing, load conversation somehow
