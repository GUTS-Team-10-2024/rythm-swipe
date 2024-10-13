extends AudioStreamPlayer2D

# Variables to control the BPM increase
var initial_bpm = 120
var rate_of_increase = 0.5  # Rate at which the BPM increases per second
var current_time = 0.0

var song_list = ["copyright-free.mp3","hey-you.mp3","again-sometime.mp3","leap-of-faith.mp3","otis-mcmusic.mp3"]

var song_bpm = {
	"copyright-free.mp3": 124,
	"hey-you.mp3":120,
	"again-sometime.mp3":120,
	"leap-of-faith.mp3":140,
	"otis-mcmusic.mp3": 184
}

func _ready():
	
	var random_song = get_random_song(song_list)
	initial_bpm = song_bpm[random_song]
	print(random_song)
	load_song(random_song)	
	play()

func get_random_song(songs):
	randomize()  # Ensure randomness
	var random_index = randi() % songs.size()
	return songs[random_index]

func _process(delta):
	# Continuously increase the pitch scale
	var new_bpm = initial_bpm + rate_of_increase * current_time
	pitch_scale = new_bpm / initial_bpm
	current_time += delta

func load_song(song_name):
	stream = load("res://songs/" + song_name)
	initial_bpm = song_bpm[song_name]
	current_time = 0.0
	play()
