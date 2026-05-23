extends Node
class_name ThreeDCharacter

enum SPRITE_STATE {HAPPY, UPSET, NERVOUS, SCARED, TERRIFIED, LAUGHING, CRYING}

@export var sprite_emotion: SPRITE_STATE
@export var character_name: String
@export var has_one_line: bool
@export var one_line: String # just for testing, probably less than ideal to use
@export var conversation_id: int # also might be changed later :)
