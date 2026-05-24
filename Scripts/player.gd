extends CharacterBody3D
class_name ThreeDPlayer



@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var camera: PlayerCam
@export var interaction_component: InteractionManager

var movement_locked: bool = false

func _physics_process(delta: float) -> void:
	input_component.gather()
	if (not movement_locked):
		camera.rotate_view(delta, input_component.look_input)
		movement_component.move(delta, input_component.wasd_input)
	# print("test2")
	
	
func _ready():
	print("test")

func lock_movement():
	movement_locked = true

func unlock_movement():
	movement_locked = false
