extends StaticBody3D
class_name BillboardCharacter

enum SPRITE_STATE {HAPPY, UPSET, NERVOUS, SCARED, TERRIFIED, LAUGHING, CRYING, SURPRISED, FLUSTERED}
enum CHARACTER {CHIAKI, KAZUICHI, KYOKO}

var backup_sprite = "uid://dbhiay3ahlwns"

var sprite_db = {
	"KAZUICHI": {
		"SURPRISED": "uid://c3l8o0qigvnfi"
	},
	"CHIAKI": {
		"UPSET": "uid://dcoeactq138y2"
	},
	"KYOKO": {
		"FLUSTERED": "uid://bdo6lt301h5vh"
	}
}

var name_db = {
	"KAZUICHI": "Kazuichi Soda",
	"CHIAKI": "Chiaki Nanami",
	"KYOKO": "Kyoko Kirigiri",
}

@export var sprite_emotion: SPRITE_STATE
@export var character: CHARACTER
var character_name: String
@export var has_one_line: bool
@export var one_line: String # just for testing, probably less than ideal to use
@export var conversation_id: int # also might be changed later :)

@export var character_sprite: Sprite3D

func _ready() -> void:
	var char_name = CHARACTER.keys()[character]
	var emotion_name = SPRITE_STATE.keys()[sprite_emotion]


	if sprite_db.has(char_name) and sprite_db[char_name].has(emotion_name):
		var tex = load(sprite_db[char_name][emotion_name])
		character_sprite.texture = tex
	else:
		var tex = load(backup_sprite)
		character_sprite.texture = tex
		push_warning("No sprite for %s:%s" % [char_name, emotion_name])


	if name_db.has(char_name):
		character_name = name_db[char_name]
	else:
		character_name = "FALLBACK: ERROR"
		push_warning("No sprite for %s:%s" % [char_name, emotion_name])
