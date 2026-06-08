extends InteractableComponent
# this is a specific InteractableComponent instance for Characters

var _displaying = false

func _ready() -> void:
	assert( parent is BillboardCharacter )
	began_interaction.connect(_begin_dialogue)
	continued_interaction.connect(_continue_dialogue)


func _begin_dialogue(component: InteractionComponent) -> void:
	Input.start_joy_vibration(0, 1, 0, 0.2)
	interacting_component.parent.movement_locked = true
	interacting_component.parent.hud.change_to_dialogue(parent.character_name)
	
	if parent.has_one_line:
		interacting_component.parent.hud.dialogue_text.display_finished.connect(_end_display)
		interacting_component.parent.hud.dialogue_text.display_text(parent.one_line)
		_displaying = true

func _end_display() -> void:
	_displaying = false
	interacting_component.parent.hud.dialogue_text.display_finished.disconnect(_end_display)


func _continue_dialogue(component: InteractionComponent) -> void:
	if not _displaying:
		_end_dialogue()


func _end_dialogue() -> void:
	interacting_component.parent.movement_locked = false
	interacting_component.parent.hud.change_to_3d()
	
	end_interact()


func get_parent_name() -> String:
	return parent.character_name
