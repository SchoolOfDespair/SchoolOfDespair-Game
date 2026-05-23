## Camera for player
class_name PlayerCam extends Camera3D


## Maximum angle up or down that camera can tilt
@export var pitch_clamp_degrees := 85.0


## Rotates by to [param mouse_look]
func rotate_view(delta: float, mouse_look: Vector2) -> void:
	
	rotation += Vector3(-mouse_look.y, 0, 0) * 0.1 * delta
	
	get_parent_node_3d().rotation += Vector3(0,-mouse_look.x,0) * 0.1 * delta
	
	rotation_degrees.x = clamp(rotation_degrees.x, -pitch_clamp_degrees, pitch_clamp_degrees)
