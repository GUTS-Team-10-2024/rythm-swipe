extends Area2D
signal hit

@export var speed = 300
@export var direction = 0
# for points!
@export var dead_zone = 1080
@export var perfect_zone_y = 850 # middle of the sweet zone
@export var max_distance = 100

var velocity = Vector2.ZERO

# mobile swiping
var startPos: Vector2
var endPos: Vector2
const threshold = 70
var startTime: int
var endTime: int


func _input(event):
	if Input.is_action_just_pressed("tap"):
		startPos = get_global_mouse_position()
		startTime = get_process_delta_time()
	if Input.is_action_just_released("tap"):
		endPos = get_global_mouse_position()
		endTime = get_process_delta_time()


func getSwipe():
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
	elif endTime == startTime and startPos.distance_squared_to(endPos) < 10:
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.DOWN * speed
	position += velocity * delta
	$AnimatedSprite2D.play()
	
	var up_bound   = position.y > perfect_zone_y - max_distance
	var down_bound = position.y < perfect_zone_y + max_distance
	if up_bound and down_bound: # the perfect zone
		# handle input
		var user_pressed = [false, false, false, false, false]
		var swipe = getSwipe()
		user_pressed[0] = Input.is_action_pressed("left") or swipe == "left"
		user_pressed[1] = Input.is_action_pressed("up") or swipe == "up"
		user_pressed[2] = Input.is_action_pressed("hit") or swipe == "tap"
		user_pressed[3] = Input.is_action_pressed("down") or swipe == "down"
		user_pressed[4] = Input.is_action_pressed("right") or swipe == "right"
		
		if user_pressed[direction]:
			var dist = position.y - perfect_zone_y
			Player.add_score(dist)
			Player.spawn_bubbles[direction] = true
			queue_free()
	
	if position.y > dead_zone:
		Player.take_damage()
		queue_free()
