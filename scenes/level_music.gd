extends AudioStreamPlayer2D

# Variables to control the BPM increase
var target_bpm = 180
var initial_bpm = 120
var duration = 60.0  # Duration over which the BPM will increase (in seconds)
var current_time = 0.0

var song_bpm = {
	"thick-of-it.mp3": 120
}

func _ready():
	# Start playing the music
	play()

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


func _on_play_button_pressed() -> void:
	load_song("thick-of-it.mp3") # Replace with function body.
