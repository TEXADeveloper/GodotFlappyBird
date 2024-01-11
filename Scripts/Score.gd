extends Control

class_name Score;

@export var label: Label
var score: int = 0

func add_score():
	score += 1
	label.text = str(score)
	pass
