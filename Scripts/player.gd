extends CharacterBody3D


@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var camera_component: CameraComponent


func _ready() -> void:
	assert(input_component != null)
	assert(movement_component != null)
	assert(camera_component != null)


func _physics_process(delta: float) -> void:
	
	input_component.gather()
	camera_component.rotate_view(delta, input_component.mouse_input)
	movement_component.move(delta, input_component.wasd_input)

	
