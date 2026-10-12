## Component to handle input
class_name InputComponent extends Node


## Type of device connected
enum DEVICE {
	M_AND_KBOARD,
	GAMEPAD
}
var _current_device: DEVICE = DEVICE.M_AND_KBOARD

## Get gamepad look input to around parity speed with mouse
const GAMEPAD_LOOK_MULTIPLIER: float = 25.0

## Detecting controller deadzone
@export var deadzone := 0.05


var _movement_input: Vector2
## Public forward backward left right vector from keyboard input
var movement_input: Vector2:
	get:
		return _movement_input
	set(value):
		pass


var _look_input: Vector2
## Relative mouse movement this frame
var look_input: Vector2:
	get:
		return _look_input
	set(value):
		pass


var _interact_input: bool
## Relative mouse movement this frame
var interact_input: bool:
	get:
		return _interact_input
	set(value):
		pass

## Raw mouse input
var mouse_input: Vector2
var _mouse_input_buffer: Vector2
var _mouse_input_got_this_frame := false


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


## Collect input from devices
func gather() -> void:
	_update_mouse_input()
	
	_update_movement_input()
	_update_look_input()
	_update_interact_input()



func _input(event: InputEvent) -> void:
	# switch current device between mouse and keyboard or gamepad depending
	# on input
	if event is InputEventKey or event is InputEventMouseButton:
		_current_device = DEVICE.M_AND_KBOARD
	elif event is InputEventJoypadButton:
		_current_device = DEVICE.GAMEPAD
	elif event is InputEventJoypadMotion:
		if event.axis_value > deadzone:
			_current_device = DEVICE.GAMEPAD
	
	
	if not event is InputEventMouseMotion \
			or Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	
	_mouse_input_buffer += event.relative
	_mouse_input_got_this_frame = true


func _update_mouse_input():
	if _mouse_input_got_this_frame:
		_mouse_input_got_this_frame = false
		mouse_input = _mouse_input_buffer
		_mouse_input_buffer = Vector2.ZERO
	else:
		mouse_input = Vector2.ZERO


func _update_movement_input():
	_movement_input = Input.get_vector("left", "right", "forward", "backward")

func _update_look_input():
	match _current_device:
		DEVICE.M_AND_KBOARD:
			_look_input = mouse_input
		DEVICE.GAMEPAD:
			var gamepad_look = Input.get_vector(
				"camleft", "camright", "camup", "camdown"
			)
			_look_input = gamepad_look * GAMEPAD_LOOK_MULTIPLIER

func _update_interact_input():
	_interact_input = Input.is_action_just_pressed("interact")
