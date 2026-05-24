## Component to handle moving [CharacterBody3D]
class_name MovementComponent extends Node

## Temporary variable for when in 3D mode but in conversation
var movement_locked: bool = false

## [CharacterBody3D] to use
@export var body: CharacterBody3D

## Speed value
@export var speed := 400.0


## Call to move [member body] based on [param input] and [member speed] relative to [member camera]
func move(delta: float, input: Vector2) -> void:
	if (movement_locked): return
	var left_direction = Vector3(body.basis.x.x, 0, body.basis.x.z).normalized() 
	var forward_direction = Vector3(body.basis.z.x, 0, body.basis.z.z).normalized()
	body.velocity = ((left_direction * input.x) + (forward_direction * input.y)) * speed * delta
	
	body.move_and_slide()

func lock_movement():
	movement_locked = true
	
func unlock_movement():
	movement_locked = false
