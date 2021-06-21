extends Label


func _process(delta):
	text = Multiplayer.debug_info()
