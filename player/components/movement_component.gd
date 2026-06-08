## Component to handle moving [CharacterBody3D]
class_name MovementComponent extends Node


## [CharacterBody3D] to move
@export var body: CharacterBody3D


## How fast?
@export var speed := 400.0


## Call to move [member body] based on [param input] at [member speed]
func move(delta: float, input: Vector2) -> void:
	var left_direction = Vector3(body.basis.x.x, 0, body.basis.x.z).normalized() 
	var forward_direction = Vector3(body.basis.z.x, 0, body.basis.z.z).normalized()
	body.velocity = ((left_direction * input.x) + (forward_direction * input.y)) * speed * delta
	
	body.move_and_slide()
