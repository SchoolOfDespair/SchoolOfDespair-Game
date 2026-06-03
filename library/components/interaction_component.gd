## A reuseable component allowing for interaction with [InteractableComponent] objects
class_name InteractionComponent extends Area3D


## Emitted when an interactable object (a node with an [InteractableComponent] child) 
## enters this [InteractionComponent]'s area
signal interactable_encountered(obj: InteractableComponent)
## Emitted when the current interactable object (a node with an [InteractableComponent] child) 
## leaves this [InteractionComponent]'s area
signal interactable_left()


@onready var parent = get_parent()


var _interacting := false
var _focused_obj: InteractableComponent


func _ready() -> void:
	area_shape_entered.connect(_register_interactable)
	area_shape_exited.connect(_deregister_interactable)


func _register_interactable(_rid, area: Area3D, _area_shape_index, _local_shape_index):
	if area is InteractableComponent:
		print("Interactable entered")
		_focused_obj = area
		interactable_encountered.emit(_focused_obj)

func _deregister_interactable(_rid, area: Area3D, _area_shape_index, _local_shape_index):
	if area == _focused_obj:
		print("Interactable left")
		_focused_obj = null
		interactable_left.emit()
		

## Start interaction with current focused object (object with 
## InteractableComponent in the InteractionComponent's area)
func interact():
	if not _focused_obj:
		return
	
	if  _interacting:
		_focused_obj.continue_interact()
	else:
		_interacting = true
		_focused_obj.start_interact(self)
		_focused_obj.ended_interaction.connect(_end_interact)

func _end_interact(component: InteractionComponent):
	_interacting = false
	_focused_obj.ended_interaction.disconnect(_end_interact)
