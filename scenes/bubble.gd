extends AnimatedSprite2D

const FINAL_FRAME = 2

func _process(delta) -> void:
	play()
	if frame == FINAL_FRAME:
		queue_free()
