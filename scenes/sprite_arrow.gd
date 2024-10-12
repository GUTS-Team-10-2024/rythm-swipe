extends Area2D
signal hit

@export var speed = 200
@export var direction = 0
var screen_size

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
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
	
	#if Input.is_action_pressed("ui_left"):
		#visible = not visible
		
		


#func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#hide()
	#hit.emit()
	#$CollisionShape2D.set_deferred("disabled", true)
