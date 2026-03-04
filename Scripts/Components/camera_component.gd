## Component to handle Camera
class_name CameraComponent extends Node

## [Camera3D] to use
@export var camera: Camera3D

## Maximum angle up or down that camera can tilt
@export var pitch_clamp_degrees := 85.0


## Rotates [member camera] relative to [param mouse_look]
func rotate_view(delta: float, mouse_look: Vector2) -> void:
	
	camera.rotation += Vector3(-mouse_look.y , -mouse_look.x, 0) * 0.1 * delta
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -pitch_clamp_degrees, pitch_clamp_degrees)
