extends Label


func _process(delta: float) -> void:
	self.text = "Speed: " + str(get_parent().get_speed())
