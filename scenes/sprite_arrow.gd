extends Area2D
signal hit

@export var speed = 300
@export var direction = 0
# for points!
var dead_zone
var perfect_zone
@export var dead_zone_height_ratio = 0.9
@export var perfect_zone_y = 850 # middle of the sweet zone
@export var max_distance = 100

var velocity = Vector2.ZERO

# mobile swiping
var startPos: Vector2
var endPos: Vector2
const threshold = 50


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("tap"):
		startPos = event.position
	if Input.is_action_just_released("tap"):
		endPos = event.position
		getSwipe()

func getSwipe():
	if Input.is_action_just_pressed("tap"):
		startPos = get_global_mouse_position()
	if Input.is_action_just_released("tap"):
		endPos = get_global_mouse_position()
	var d := endPos - startPos
	if d.length_squared() > threshold: 
		if abs(d.x) > abs(d.y):
			if d.x < 0:
				return "left"
			else:
				return "right"
		else:
			if d.y > 0:
				return "down"
			else:
				return "up"
	elif startPos.distance_to(endPos) == 0:
		return "tap"

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
	if Input.is_action_pressed("left") or getSwipe() == "left":
		user_pressed = 0
	if Input.is_action_pressed("up") or getSwipe() == "up":
		user_pressed = 1
	if Input.is_action_pressed("hit") or getSwipe() == "tap":
		user_pressed = 2
	if Input.is_action_pressed("down") or getSwipe() == "down":
		user_pressed = 3
	if Input.is_action_pressed("right") or getSwipe() == "right":
		user_pressed = 4
	
	velocity = Vector2.DOWN * speed
	position += velocity * delta
	$AnimatedSprite2D.play()
	
	var up_bound   = position.y > perfect_zone_y - max_distance
	var down_bound = position.y < perfect_zone_y + max_distance
	if up_bound and down_bound: # the perfect zone
		if user_pressed == direction:
			var dist = position.y - perfect_zone_y
			#print("nice!", dist, position.y)
			Player.add_score(dist)
			queue_free()
	
	if position.y > dead_zone:
		Player.take_damage()
		queue_free()
		
	# check shape and input
