extends Node2D

@export var arrow_scene: PackedScene
var score
@export var left_arrow_spawn_position  = 0.10
@export var up_arrow_spawn_position    = 0.25
@export var hit_spawn_position         = 0.50
@export var down_arrow_spawn_position  = 0.75
@export var right_arrow_spawn_position = 0.90

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func new_game() -> void:
	score = 0
	$SpawnTimer.start()

func game_over() -> void:
	print(score)
	$SpawnTimer.stop()

# Spawn Timer Tick
func _on_spawn_timer_timeout() -> void:
	var new_arrow = arrow_scene.instantiate()
	var arrow_spawn_location = $SpawnPath/SpawnLocation
	var d = randi_range(0, 5)
	if d == 0:
		arrow_spawn_location.progress_ratio = left_arrow_spawn_position
		# TODO set the tyoe (direction) of the arrow
	elif d == 1:
		arrow_spawn_location.progress_ratio = up_arrow_spawn_position
	elif d == 2:
		arrow_spawn_location.progress_ratio = hit_spawn_position
	elif d == 3:
		arrow_spawn_location.progress_ratio = down_arrow_spawn_position
	else:
		arrow_spawn_location.progress_ratio = right_arrow_spawn_position
	new_arrow.position = arrow_spawn_location.position
	
	add_child(new_arrow) # now the arrow becomes active
	
