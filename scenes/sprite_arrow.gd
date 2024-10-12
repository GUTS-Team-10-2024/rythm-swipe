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
		if Input.is_action_pressed("left") or swipe == "left":
			user_pressed[0] = true
		if Input.is_action_pressed("up") or swipe == "up":
			user_pressed[1] = true
		if Input.is_action_pressed("hit") or swipe == "tap":
			user_pressed[2] = true
		if Input.is_action_pressed("down") or swipe == "down":
			user_pressed[3] = true
		if Input.is_action_pressed("right") or swipe == "right":
			user_pressed[4] = true
		
		if user_pressed[direction]:
			var valid = false
			if direction == 2:
				# special case just for hit
				if not (user_pressed[0] or user_pressed[1] or user_pressed[3] or user_pressed[4]):
					valid = true
			else:
				valid = true
			if valid:
				var dist = position.y - perfect_zone_y
				Player.add_score(dist)
				queue_free()
	
	if position.y > dead_zone:
		Player.take_damage()
		queue_free()
