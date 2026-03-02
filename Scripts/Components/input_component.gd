class_name InputComponent extends Node


@export var mouse_sens := 1.0


var wasd_input: Vector2

var mouse_input: Vector2
var _mouse_input_buffer: Vector2
var _mouse_input_got_this_frame := false


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
	if _mouse_input_got_this_frame:
		_mouse_input_got_this_frame = false
		mouse_input = _mouse_input_buffer
	else:
		mouse_input = Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseMotion \
	or Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	
	mouse_input = event.relative * mouse_sens
	_mouse_input_got_this_frame = true


func gather() -> void:
	wasd_input = Input.get_vector("left", "right", "forward", "backward")
