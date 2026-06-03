## A reuseable component designating its parent as an interactable object.
@abstract 
class_name InteractableComponent 
extends Area3D

## Emitted the first time an [InteractionComponent] interacts with this node.
signal began_interaction(component: InteractionComponent)
## Emitted subsequent times an [InteractionComponent] interacts with this node.
signal continued_interaction(component: InteractionComponent)
## Emitted when interaction ends.
signal ended_interaction(component: InteractionComponent)


@onready var parent: Node = get_parent()

## [InteractionComponent] we are currently interacting with.
var interacting_component: InteractionComponent = null


## Begin interaction with [param component].
func start_interact(component: InteractionComponent) -> void:
	interacting_component = component
	began_interaction.emit(interacting_component)

## Continue interaction with [member interacting_component].
func continue_interact() -> void:
	continued_interaction.emit(interacting_component)

## End interaction with [member interacting_component].
func end_interact() -> void:
	ended_interaction.emit(interacting_component)
	interacting_component = null

## Return the name of the object this [InteractableComponent] is for (used for tooltips, etc).
@abstract func get_parent_name() -> String
