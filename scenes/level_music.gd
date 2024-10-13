extends AudioStreamPlayer2D

# Variables to control the BPM increase
var target_bpm = 180
var initial_bpm = 120
var duration = 180.0 # Duration over which the BPM will increase (in seconds)
var current_time = 0.0

var song_list = ["desert_rose.mp3","disarray.mp3","loop_2.mp3","loop_18.mp3","uplifting.mp3"]

var song_bpm = {
	"desert_rose.mp3": 90,
	"disarray.mp3": 120,
	"loop_2.mp3": 79,
	"loop_18.mp3": 70,
	"uplifting.mp3": 110
}

func _ready():
	var random_song = get_random_song(song_list)
	print(random_song)
	load_song(random_song)	
	play()

func get_random_song(songs):
	randomize()  # Ensure randomness
	var random_index = randi() % songs.size()
	return songs[random_index]

func _process(delta):
	if current_time < duration:
		current_time += delta
		# Calculate the new pitch scale based on the elapsed time
		var new_bpm = initial_bpm + (target_bpm - initial_bpm) * (current_time / duration)
		pitch_scale = new_bpm / initial_bpm

func load_song(song_name):
	stream = load("res://songs/" + song_name)
	initial_bpm = song_bpm[song_name]
	current_time = 0.0
	play()
