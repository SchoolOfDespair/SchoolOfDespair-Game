## Label which can display text one char at a time
class_name DialogueLabel extends AutoSizeRichTextLabel

signal display_finished

enum DISPLAY_STAGE {WAITING, DISPLAYING, DISPLAYED}

## DialogueResource to use - no more
# @export var dialogue_line: DialogueResource

var text_being_displayed: String

var _timer: Timer

## How long to wait between characters being output to label
var text_speed = 0.05

@export var _display_stage: DISPLAY_STAGE = DISPLAY_STAGE.DISPLAYED
var _time_since_last_update = 0.0
var _current_index = 0


func _ready():
	_timer = Timer.new()
	add_child(_timer)
	
	#_timer.timeout.connect(_display_next_char)
	
	text = ""


func _process(delta):
	if _display_stage == DISPLAY_STAGE.DISPLAYED:
		_timer.stop()


func _display_next_char():
	visible_characters = _current_index
	_current_index += 1
	
	if _current_index == len(text_being_displayed):
		_display_stage = DISPLAY_STAGE.DISPLAYED
		display_finished.emit()

## Start process of displaying text
func begin_displaying_text():
	visible_characters = 0
	text = text_being_displayed
	if _display_stage != DISPLAY_STAGE.DISPLAYING:
		_timer.start(text_speed)
		_display_stage = DISPLAY_STAGE.DISPLAYING
	


func display_text(text1: String):
	if (_display_stage == DISPLAY_STAGE.DISPLAYED):
		_current_index = 0
		_display_stage = DISPLAY_STAGE.WAITING
		text = ""
		text_being_displayed = text1
	
		_timer = Timer.new()
		add_child(_timer)
		_timer.timeout.connect(_display_next_char)
	
		begin_displaying_text()
	#else:
	#	_display_stage = DISPLAY_STAGE.DISPLAYED
	#	display_finished.emit()
	#	visible_characters = len(text_being_displayed)
	# do this later, essentialy skip button
