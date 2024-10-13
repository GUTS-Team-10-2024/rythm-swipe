extends AudioStreamPlayer2D

# Variables to control the BPM increase
var initial_bpm
# Duration over which the BPM will increase (in seconds)
var rate_of_increase = 0.5  # Rate at which the BPM increases per second
# Duration of the loop
var current_pitch_scale = 1.0
@export var duration = 500.0 # the smaller this is, the faster it gets faster
var song
var song_list = ["copyright-free.mp3","hey-you.mp3","again-sometime.mp3","leap-of-faith.mp3","otis-mcmusic.mp3"]

var song_bpm = {
	"copyright-free.mp3": 124,
	"hey-you.mp3":120,
	"again-sometime.mp3":120,
	"leap-of-faith.mp3":140,
	"otis-mcmusic.mp3": 184
}

func _ready():
	if Player.selected_song == -1:
		song = get_random_song(Player.song_list)
	else:
		song = Player.song_list[Player.selected_song]
	initial_bpm = Player.song_bpm[song]
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

		#to do: comment one of these
		# Continuously increase the pitch scale
	    var new_bpm = initial_bpm + rate_of_increase * current_time
	    pitch_scale = new_bpm / initial_bpm
	    current_time += delta

		current_pitch_scale = (initial_bpm + initial_bpm * (get_playback_position() / duration)) / initial_bpm
		pitch_scale = current_pitch_scale

func load_song(song_name):
	stream = load("res://songs/" + song_name)
	pitch_scale = current_pitch_scale
	initial_bpm = Player.song_bpm[song_name]
	play()


func _on_finished() -> void:
	load_song(song)


func get_current_pitch_scale():
	return current_pitch_scale


func get_bpm():
	return initial_bpm
