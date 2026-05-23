class_name InteractionManager extends Node

# mkay i can't be arsed to make this right now but
# essentially, this is what tells the UI what we interacted with and what we can interact with by using either raycasting a few units infront or
# it uses a collider as a trigger (at least that's what it's called in Unity), to see what we're looking at, to which the UI can update, showing
# the reticle and the information box telling the player what they're looking at, most likely a character

@export var area3d: Area3D

@export var ui_manager: UIManager

var current_focused_object

func _ready() -> void:
	area3d.body_entered.connect(_on_area_entered)
	area3d.body_exited.connect(_on_area_exited)
	print("Interaction Manager Ready")
	ui_manager.unfocus()

func _on_area_entered(obj):
	if (not obj.name == "3DPlayer"):
		print(obj.name)
		print("^ entered")
		current_focused_object = obj
		ui_manager.focus(obj.name)

func _on_area_exited(obj):
	if (not obj.name == "3DPlayer"):
		print(obj.name)
		print("^ exited")
		ui_manager.unfocus()

# func interact():
	# todo
