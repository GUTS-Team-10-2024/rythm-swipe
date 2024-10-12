extends Area2D
signal hit

@export var speed = 100
@export var direction = 0
# for points!
var dead_zone
var perfect_zone
@export var dead_zone_height_ratio = 0.9
@export var perfect_zone_height_ratio = 0.8
@export var max_distance = 100

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	var size_y = get_viewport_rect().size.y
	dead_zone = size_y * dead_zone_height_ratio
	perfect_zone = -size_y * perfect_zone_height_ratio


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var user_pressed = -1
	if Input.is_action_pressed("left"):
		user_pressed = 0
	if Input.is_action_pressed("up"):
		user_pressed = 1
	if Input.is_action_pressed("hit"):
		user_pressed = 2
	if Input.is_action_pressed("down"):
		user_pressed = 3
	if Input.is_action_pressed("right"):
		user_pressed = 4
	
	velocity = Vector2.DOWN * speed
	position += velocity * delta
	
	if position.y > perfect_zone - max_distance or position.y < perfect_zone + max_distance:
		if user_pressed == direction:
			var dist = position.y - perfect_zone
			print("nice!", dist, position.y)
			# TODO get score
			queue_free()
	
	if position.y > dead_zone:
		# TODO take damage
		queue_free()
		
	# check shape and input
