extends AudioStreamPlayer2D

# Variables to control the BPM increase
var initial_bpm
# Duration over which the BPM will increase (in seconds)
# Duration of the loop
var current_pitch_scale = 1.0
@export var duration = 500.0 # the smaller this is, the faster it gets faster
var song

var song_list = ["desert_rose.mp3","disarray.mp3","loop_2.mp3","loop_18.mp3","uplifting.mp3"]

var song_bpm = {
	"desert_rose.mp3": 90,
	"disarray.mp3": 120,
	"loop_2.mp3": 79,
	"loop_18.mp3": 70,
	"uplifting.mp3": 110
}

func _ready():
	song = get_random_song(song_list)
	print(song)
	load_song(song)
	play()

func get_random_song(songs):
	randomize()  # Ensure randomness
	var random_index = randi() % songs.size()
	return songs[random_index]

func speed_up():
	if get_playback_position() < duration:
		# Calculate the new pitch scale based on the elapsed time
		#var new_bpm = initial_bpm + (target_bpm - initial_bpm) * (get_playback_position() / duration)
		#pitch_scale = new_bpm / initial_bpm
		
		current_pitch_scale = (initial_bpm + initial_bpm * (get_playback_position() / duration)) / initial_bpm
		pitch_scale = current_pitch_scale

func load_song(song_name):
	stream = load("res://songs/" + song_name)
	pitch_scale = current_pitch_scale
	initial_bpm = song_bpm[song_name]
	play()


func _on_finished() -> void:
	load_song(song)
