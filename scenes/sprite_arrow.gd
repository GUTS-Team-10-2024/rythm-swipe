extends Area2D
signal hit

@export var speed = 100
var screen_size

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.DOWN * speed
	
	position += velocity * delta
	
	#if Input.is_action_pressed("ui_left"):
		#visible = not visible
		
		
