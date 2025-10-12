extends Node


var frogs_remaining = 6
var score = 0
var highscore = 0

func _process(_delta: float) -> void:
	if score >= highscore:
		highscore = score
		
