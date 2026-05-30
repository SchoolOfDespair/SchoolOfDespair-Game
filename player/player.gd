class_name Player3D extends CharacterBody3D



@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var camera: PlayerCam
@export var interaction_component: InteractionComponent

var movement_locked := false

func _process(delta: float) -> void:
	input_component.gather()
	if input_component.interact_input:
		interaction_component.interact()

func _physics_process(delta: float) -> void:
	if not movement_locked:
		camera.rotate_view(delta, input_component.look_input)
		movement_component.move(delta, input_component.movement_input)
	
	
func _ready():
	print("test")
