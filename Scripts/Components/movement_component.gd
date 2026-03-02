class_name MovementComponent extends Node


@export var body: CharacterBody3D
@export var camera: Camera3D

@export var speed := 20.0
@export var linear_damp := 0.95


func move(delta: float, input: Vector2) -> void:
	assert(body != null)
	assert(camera != null)
	
	body.velocity *= linear_damp
	
	var left_movement = Vector3(camera.basis.x.x, 0, camera.basis.x.z).normalized() * input.x * speed * delta
	var forward_movement = Vector3(camera.basis.z.x, 0, camera.basis.z.z).normalized() * input.y * speed * delta
	body.velocity += left_movement + forward_movement
	
	body.move_and_slide()
