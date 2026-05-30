extends TextureRect

var fadingout = false

func _process(delta: float) -> void:
	if (fadingout):
		if (modulate.a < 1):
			modulate.a += 1.2 * delta
		else: 	
			fadingout = false
	else:
		if (modulate.a > 0.2):
			modulate.a -= 1.2 * delta
		else: 	
			fadingout = true
		
