extends Node

var score = 0
var health = 3

func take_damage() -> void:
	health -= 1

func add_score(distance: int) -> void:
	# TODO do something with distance here
	score += 1 
