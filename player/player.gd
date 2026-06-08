## Player character
class_name Player3D extends CharacterBody3D


@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var camera: PlayerCam = %PlayerCam
@onready var interaction_component: InteractionComponent = %InteractionComponent
@onready var hud: HUD = %HUD


## Use to toggle player movement
var movement_locked := false


func _ready() -> void:
	interaction_component.interactable_encountered.connect(func (obj): hud.focus(obj.get_parent_name()))
	interaction_component.interactable_left.connect(hud.unfocus)


func _process(delta: float) -> void:
	input_component.gather()
	
	if input_component.interact_input:
		interaction_component.interact()


func _physics_process(delta: float) -> void:
	if not movement_locked:
		camera.rotate_view(delta, input_component.look_input)
		movement_component.move(delta, input_component.movement_input)
