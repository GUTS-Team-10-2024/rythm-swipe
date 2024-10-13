extends Node

var score = 0
var health = 3
var spawn_bubbles = [false, false, false, false, false]
var selected_song = -1  # default: -1, means a random song will be selected
var song_list = [
	"desert_rose.mp3",
	"disarray.mp3",
	"loop_2.mp3",
	"loop_18.mp3",
	"uplifting.mp3",
	"copyright-free.mp3",
	"hey-you.mp3",
	"again-sometime.mp3",
	"leap-of-faith.mp3",
	"otis-mcmusic.mp3"
]

var song_bpm = {
	"desert_rose.mp3": 90,
	"disarray.mp3": 120,
	"loop_2.mp3": 79,
	"loop_18.mp3": 70,
	"uplifting.mp3": 110,
	"copyright-free.mp3": 124,
	"hey-you.mp3":120,
	"again-sometime.mp3":120,
	"leap-of-faith.mp3":140,
	"otis-mcmusic.mp3": 184
}

var bpm = -1
var pitchScale = 1

func take_damage() -> void:
	health -= 1
	

func add_score(distance: int) -> void:
	# TODO do something with distance here
	score += 1 
	
