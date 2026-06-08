## Resource representing a line of dialogue
class_name DialogueResource extends Resource

## Character who says the line
@export var character: String 
## Contents of the dialogue line
@export var text: String
## Emotion used for sprite
@export var emotion: String # TODO: change to enum?
## Voiceline used for audioclip
@export var voiceline: String # TODO: change to audio file? yes



func _init(p_character = "no_character", p_text = "no_text_body", p_emotion = "neutral", p_voiceline = "none") -> void:
	character = p_character
	text = p_text
	emotion = p_emotion
	voiceline = p_voiceline
