extends Label

func _process(delta: float) -> void:
	var t = "Lives: "
	#for i in range(Player.health):
		#t += "❤️"
	self.text = t
