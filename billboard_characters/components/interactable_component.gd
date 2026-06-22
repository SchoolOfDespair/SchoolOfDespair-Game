extends InteractableComponent
# this is a specific InteractableComponent instance for Characters

var _displaying = false
var _label: DialogueLabel = null

func _ready() -> void:
	assert( parent is BillboardCharacter )
	
	#NOTICE remove when multiple lines is implemented
	assert( parent.has_one_line ) 
	
	began_interaction.connect(_begin_dialogue)
	continued_interaction.connect(_continue_dialogue)


func _begin_dialogue(component: InteractionComponent) -> void:
	Input.start_joy_vibration(0, 1, 0, 0.2)
	interacting_component.parent.movement_locked = true
	interacting_component.parent.hud.change_to_dialogue(parent.character_name)
	
	_label = interacting_component.parent.hud.dialogue_text
	_label.display_finished.connect(_end_display)
	_label.display(parent.one_line)
	_displaying = true


func _end_display() -> void:
	_displaying = false
	_label.display_finished.disconnect(_end_display)
	_label = null


func _continue_dialogue(component: InteractionComponent) -> void:
	if _displaying:
		_label.skip_displaying()
	else:
		_end_dialogue()


func _end_dialogue() -> void:
	interacting_component.parent.movement_locked = false
	interacting_component.parent.hud.change_to_3d()
	
	end_interact()


func get_parent_name() -> String:
	return parent.character_name
