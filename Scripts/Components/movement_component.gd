## Component to handle moving [CharacterBody3D]
class_name MovementComponent extends Node


## [CharacterBody3D] to use
@export var body: CharacterBody3D
## [Camera3D] to use
@export var camera: Camera3D

## Speed value
@export var speed := 400.0


## Call to move [member body] based on [param input] and [member speed] relative to [member camera]
func move(delta: float, input: Vector2) -> void:
	assert(body != null)
	assert(camera != null)
	
	
	var left_direction = Vector3(camera.basis.x.x, 0, camera.basis.x.z).normalized() 
	var forward_direction = Vector3(camera.basis.z.x, 0, camera.basis.z.z).normalized()
	body.velocity = ((left_direction * input.x) + (forward_direction * input.y)) * speed * delta
	
	body.move_and_slide()
