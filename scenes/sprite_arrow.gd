extends Area2D
signal hit

@export var speed = 200
@export var direction = 0
# for points!
var dead_zone
var perfect_zone
@export var dead_zone_height_ratio = 0.9
@export var perfect_zone_y = 850 # middle of the sweet zone
@export var max_distance = 100

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 0:
		$AnimatedSprite2D.animation = "left"
	elif direction == 1:
		$AnimatedSprite2D.animation = "up"
	elif direction == 2:
		$AnimatedSprite2D.animation = "circle"
	elif direction == 3:
		$AnimatedSprite2D.animation = "down"
	else:
		$AnimatedSprite2D.animation = "right"

	var size_y = get_viewport_rect().size.y
	dead_zone = size_y * dead_zone_height_ratio
	#perfect_zone = -size_y * perfect_zone_height_ratio



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
	$AnimatedSprite2D.play()
	
	var up_bound   = position.y > perfect_zone_y - max_distance
	var down_bound = position.y < perfect_zone_y + max_distance
	if up_bound and down_bound: # the perfect zone
		if user_pressed == direction:
			var dist = position.y - perfect_zone_y
			print("nice!", dist, position.y)
			# TODO get score
			queue_free()
	
	if position.y > dead_zone:
		# TODO take damage
		queue_free()
		
	# check shape and input
