## Component to handle input
class_name InputComponent extends Node


## Type of device connected
enum DEVICE {
	M_AND_KBOARD,
	GAMEPAD
}
var _current_device: DEVICE = DEVICE.M_AND_KBOARD


const GAMEPAD_LOOK_MULTIPLIER: float = 20.0

## Detecting controller deadzone
@export var deadzone := 0.05

## Mouse sensitivity
@export var look_sens := 2.0


var _wasd_input: Vector2
## Public forward backward left right vector from keyboard input
var wasd_input: Vector2:
	get:
		return _wasd_input
	set(value):
		pass


var _look_input: Vector2
## Relative mouse movement this frame
var look_input: Vector2:
	get:
		return _look_input
	set(value):
		pass


var mouse_input: Vector2
var _mouse_input_buffer: Vector2
var _mouse_input_got_this_frame := false




func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:	
	_update_mouse_input()
	
	var gamepad_input = Input.get_vector("camleft", "camright", "camup", "camdown")
	
	if _current_device == DEVICE.M_AND_KBOARD:
		_look_input = mouse_input
	elif _current_device == DEVICE.GAMEPAD:
		_look_input = gamepad_input * GAMEPAD_LOOK_MULTIPLIER


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventMouseButton:
		_current_device = DEVICE.M_AND_KBOARD
	elif event is InputEventJoypadButton:
		_current_device = DEVICE.GAMEPAD
	elif event is InputEventJoypadMotion:
		if event.axis_value > deadzone:
			_current_device = DEVICE.GAMEPAD
	
	
	if event is not InputEventMouseMotion \
	or Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	
	_mouse_input_buffer += event.relative * look_sens
	_mouse_input_got_this_frame = true


## Retrieve left right forward backward from input map and put in [member wasd_input]
func gather() -> void:
	_wasd_input = Input.get_vector("left", "right", "forward", "backward")

func _update_mouse_input():
	if _mouse_input_got_this_frame:
		_mouse_input_got_this_frame = false
		mouse_input = _mouse_input_buffer
		_mouse_input_buffer = Vector2.ZERO
	else:
		mouse_input = Vector2.ZERO
