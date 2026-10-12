## Camera for player
class_name PlayerCam extends Camera3D


## Maximum angle up and down that camera can tilt
@export_range(0, 90) var pitch_clamp_degrees := 85.0
var _pitch_clamp: float
## Sensitivity in radians/pixel/second
@export var sensitivity: float = 0.1
## Whether camera should rotate Y relative to parent or rotate its (3d) parent 
@export var rotate_parent_3d: bool

var _to_rotate: Node3D

func _ready() -> void:
	if rotate_parent_3d:
		_to_rotate = get_parent_node_3d()
	else:
		_to_rotate = self
	
	_pitch_clamp = cos(deg_to_rad(pitch_clamp_degrees))


## Rotates by [param mouse_look]
func rotate_view(delta: float, mouse_look: Vector2) -> void:
	if mouse_look == Vector2.ZERO:
		return
	
	var rotation := -mouse_look * sensitivity * delta
	
	var rotated_basis := _to_rotate.basis
	rotated_basis = rotated_basis.rotated(rotated_basis.x, rotation.y)
	if rotated_basis.y.dot(Vector3.UP) < _pitch_clamp:
		rotated_basis = _to_rotate.basis
		print("over clamp angle")
	rotated_basis = rotated_basis.rotated(Vector3.UP, rotation.x)
	
	_to_rotate.basis = rotated_basis
