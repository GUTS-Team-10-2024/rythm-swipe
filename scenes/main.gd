extends Node2D

@export var arrow_scene: PackedScene
@export var bubble_scene: PackedScene
# Arrow Spawn X values
@export var left_arrow_spawn_position  = 0.20
@export var up_arrow_spawn_position    = 0.35
@export var hit_spawn_position         = 0.50
@export var down_arrow_spawn_position  = 0.65
@export var right_arrow_spawn_position = 0.80
# Arrow Speed
@export var arrow_start_speed           = 200
@export var speed_increase_per_new_ball = 3.5
# Bubble
@export var bubble_spawn_xs = [160, 280, 400, 520, 640]
@export var bubble_spawn_y  = 810

func _ready() -> void:
	Player.health = 3
	Player.score = 0

func _process(delta: float) -> void:
	if Player.health == 2:
		$Heart3.visible = false
	if Player.health == 1:
		$Heart2.visible = false
	if Player.health == 0:
		game_over()
		$Heart.visible = false
	
	# spawn bubbles 
	for i in range(5):
		if Player.spawn_bubbles[i]:
			Player.spawn_bubbles[i] = false
			var new_bubble = bubble_scene.instantiate()
			new_bubble.position = Vector2(bubble_spawn_xs[i], bubble_spawn_y)
			new_bubble.rotation = randf_range(0, 4 * PI)
			add_child(new_bubble)

func new_game() -> void:
	Player.score = 0
	Player.health = 3
	$Heart.visible = true
	$Heart2.visible = true
	$Heart3.visible = true
	arrow_start_speed = 200
	$SpawnTimer.start()
	set_process(true)

func game_over() -> void:
	set_process(false)
	$GameOverScreen.visible = true
	$SpawnTimer.stop()

func speed_up() -> void:
	arrow_start_speed += speed_increase_per_new_ball
	$LevelMusic.speed_up()

# Spawn Timer Tick
func _on_spawn_timer_timeout() -> void:
	speed_up()
	var new_arrow = arrow_scene.instantiate()
	var arrow_spawn_location = $SpawnPath/SpawnLocation
	var d = randi_range(0, 4)
	if d == 0:
		arrow_spawn_location.progress_ratio = left_arrow_spawn_position
	elif d == 1:
		arrow_spawn_location.progress_ratio = up_arrow_spawn_position
	elif d == 2:
		arrow_spawn_location.progress_ratio = hit_spawn_position
	elif d == 3:
		arrow_spawn_location.progress_ratio = down_arrow_spawn_position
	else:
		arrow_spawn_location.progress_ratio = right_arrow_spawn_position
	new_arrow.position = arrow_spawn_location.position
	new_arrow.speed = arrow_start_speed
	new_arrow.direction = d
	
	add_child(new_arrow) # now the arrow becomes active

func get_speed() -> int:
	return arrow_start_speed

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/StartMenu.tscn")
