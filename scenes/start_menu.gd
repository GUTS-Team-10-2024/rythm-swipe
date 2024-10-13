extends Node2D
#var current_selection = -1

func _ready() -> void:
	for i in range(len(Player.song_list)):
		$OptionButton.add_item(Player.song_list[i], i)
	$OptionButton.selected = -1

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_option_button_item_selected(index: int) -> void:
	Player.selected_song = 0
