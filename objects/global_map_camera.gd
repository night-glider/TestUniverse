extends Camera2D

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -=10
	if Input.is_action_pressed("ui_down"):
		position.y +=10
	if Input.is_action_pressed("ui_left"):
		position.x -=10
	if Input.is_action_pressed("ui_right"):
		position.x +=10
	if Input.is_action_pressed("ui_accept"):
		zoom.x += 0.1
		zoom.y += 0.1
	if Input.is_action_pressed("ui_cancel"):
		zoom.x -= 0.1
		zoom.y -= 0.1
		
	print(Performance.get_monitor(Performance.TIME_FPS))



