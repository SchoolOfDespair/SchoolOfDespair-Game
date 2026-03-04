## Label which can display text one char at a time
class_name DialogueLabel extends RichTextLabel

enum DISPLAY_STAGE {WAITING, DISPLAYING, DISPLAYED}

## DialogueResource to use
@export var dialogue_line: DialogueResource

var _timer: Timer

## How long to wait between characters being output to label
var text_speed = 0.05

var _display_stage: DISPLAY_STAGE = DISPLAY_STAGE.WAITING
var _time_since_last_update = 0.0
var _current_index = 0


func _ready():
	_timer = Timer.new()
	add_child(_timer)
	_timer.timeout.connect(_display_next_char)
	
	text = ""


func _process(delta):
	if _display_stage == DISPLAY_STAGE.DISPLAYED:
		_timer.stop()


func _display_next_char():
	var to_add = dialogue_line.text[_current_index]
	if to_add == "[":
		# Skip over the rich text tags
		var tagEndIndex = dialogue_line.text.find("]", _current_index)
		if tagEndIndex != -1:
			to_add =  dialogue_line.text.substr(_current_index, (tagEndIndex - _current_index) + 1)
			_current_index = tagEndIndex
	
	text += to_add
	_current_index += 1
	
	if _current_index == len(dialogue_line.text):
		_display_stage = DISPLAY_STAGE.DISPLAYED

## Start process of displaying text
func begin_displaying_text():
	if _display_stage != DISPLAY_STAGE.DISPLAYING:
		_timer.start(text_speed)
		_display_stage = DISPLAY_STAGE.DISPLAYING
