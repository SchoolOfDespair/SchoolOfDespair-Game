extends CharacterBody3D


@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var camera: PlayerCam
@export var interaction_component: InteractionManager

func _physics_process(delta: float) -> void:
	input_component.gather()
	camera.rotate_view(delta, input_component.look_input)
	movement_component.move(delta, input_component.wasd_input)
	# print("test2")
	
	
func _ready():
	print("test")
