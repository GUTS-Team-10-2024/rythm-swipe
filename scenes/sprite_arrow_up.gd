extends Sprite2D

var speed = 100

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.DOWN * speed
	
	position += velocity * delta
	
	if Input.is_action_pressed("ui_up"):
		visible = not visible
		
		
