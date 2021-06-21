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
	if Input.is_action_just_released("zoom_out"):
		zoom.x += 0.1
		zoom.y += 0.1
	if Input.is_action_just_released("zoom_in"):
		zoom.x -= 0.1
		zoom.y -= 0.1



