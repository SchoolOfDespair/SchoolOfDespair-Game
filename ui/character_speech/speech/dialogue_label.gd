## Label which can display text one char at a time
class_name DialogueLabel extends AutoSizeRichTextLabel

## Signal emitted when all characters are displayed
signal display_finished

## How long to wait between characters being output to label
@export var text_speed = 0.05

var _displaying = false
var _timer: Timer

func _ready():
	text = ""
	
	_timer = Timer.new()
	_timer.autostart = false
	add_child(_timer)
	_timer.timeout.connect(_display_next_char)


## Display [param text] one character at a time
func display(text: String):
	if _displaying:
		return
	
	_displaying = true
	visible_characters = 0
	self.text = text.strip_edges()
	
	_timer.start(text_speed)


func skip_displaying():
	if not _displaying:
		return
	visible_ratio = 1.0
	_stop_displaying()


func _display_next_char():
	visible_characters += 1
	if visible_ratio == 1.0:
		_stop_displaying()


func _stop_displaying():
	_displaying = false
	_timer.stop()
	display_finished.emit()
