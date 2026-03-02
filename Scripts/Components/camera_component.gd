class_name CameraComponent extends Node


@export var camera: Camera3D

@export var pitch_clamp_degrees := 85.0


func rotate_view(delta: float, mouse_look: Vector2) -> void:
	assert(camera != null)
	
	camera.rotation += (Vector3(-mouse_look.y , -mouse_look.x, 0) * 0.1 * delta)
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -pitch_clamp_degrees, pitch_clamp_degrees)
