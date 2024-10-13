extends AudioStreamPlayer2D

# Variables to control the BPM increase
var initial_bpm
# Duration over which the BPM will increase (in seconds)
var rate_of_increase = 0.5  # Rate at which the BPM increases per second
# Duration of the loop
var current_pitch_scale = 1.0
var current_time = 0.0
@export var duration = 500.0 # the smaller this is, the faster it gets faster
var song


func _ready():
	if Player.selected_song == -1:
		song = get_random_song(Player.song_list)
	else:
		song = Player.song_list[Player.selected_song]
	print(song)
	load_song(song)
	Player.bpm = initial_bpm
	play()

func get_random_song(songs):
	randomize()  # Ensure randomness
	var random_index = randi() % songs.size()
	return songs[random_index]

func speed_up():
	# Calculate the new pitch scale based on the elapsed time
	#var new_bpm = initial_bpm + (target_bpm - initial_bpm) * (get_playback_position() / duration)
	#pitch_scale = new_bpm / initial_bpm

	#current_pitch_scale = (initial_bpm + initial_bpm * (get_playback_position() / duration)) / initial_bpm
	#pitch_scale = current_pitch_scale

	#to do: comment one of these
	# Continuously increase the pitch scale
	current_pitch_scale = (initial_bpm + rate_of_increase * current_time)/initial_bpm
	pitch_scale = current_pitch_scale
	current_time += 2 #MAKE SURE THIS IS EQUAL TO TIMER WAIT TIME
	Player.pitchScale = pitch_scale
	

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
