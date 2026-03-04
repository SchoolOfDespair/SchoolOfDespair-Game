extends Node

@export var RTL: RichTextLabel

var timeSinceLastUpdate = 0.0
var nextCharDelay = 0.05
var currentCharIndex = 0

var textString = "Yo, I'm Randall Jackson. You can call me [color=gold][b]Randall[/b][/color]. I'm a [color=gold][b]Journalist[/b][/color]."


func _ready():
	RTL.text = ""
	pass

func _process(delta):
	while currentCharIndex < len(textString):
		timeSinceLastUpdate += delta
		if timeSinceLastUpdate >= nextCharDelay:
			if textString[currentCharIndex] == "[":
				# Skip over the rich text tags
				var tagEndIndex = textString.find("]", currentCharIndex)
				if tagEndIndex != -1:
					
					RTL.text += textString.substr(currentCharIndex, tagEndIndex - currentCharIndex + 1)
					currentCharIndex = tagEndIndex + 1
					continue
				else:
					RTL.text += textString[currentCharIndex]
			else:
				RTL.text += textString[currentCharIndex]
			timeSinceLastUpdate = 0.0
		else:
			break
		currentCharIndex += 1
