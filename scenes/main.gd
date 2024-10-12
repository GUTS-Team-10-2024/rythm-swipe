extends Node2D

@export var arrow_scene: PackedScene
@export var left_arrow_spawn_position  = 0.20
@export var up_arrow_spawn_position    = 0.35
@export var hit_spawn_position         = 0.50
@export var down_arrow_spawn_position  = 0.65
@export var right_arrow_spawn_position = 0.80
@export var arrow_start_speed = 200

func _ready() -> void:
	Player.health = 3
	Player.score = 0

func _process(delta: float) -> void:
	if Player.health == 0:
		game_over()

func new_game() -> void:
	Player.score = 0
	Player.health = 3
	arrow_start_speed = 200
	$SpawnTimer.start()
	set_process(true)

func game_over() -> void:
	set_process(false)
	$SpawnTimer.stop()

# Spawn Timer Tick
func _on_spawn_timer_timeout() -> void:
	arrow_start_speed += 1
	var new_arrow = arrow_scene.instantiate()
	var arrow_spawn_location = $SpawnPath/SpawnLocation
	var d = randi_range(0, 5)
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
