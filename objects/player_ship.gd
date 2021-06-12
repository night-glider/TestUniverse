extends Node2D

var room_id = 0



func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation_degrees-=2
	if Input.is_action_pressed("ui_right"):
		rotation_degrees+=2
	if Input.is_action_pressed("ui_up"):
		position+=Vector2.RIGHT.rotated(rotation)*10
		
	if Input.is_action_just_released("zoom_out"):
		$Camera2D.zoom.x += 0.1
		$Camera2D.zoom.y += 0.1
	if Input.is_action_just_released("zoom_in"):
		$Camera2D.zoom.x -= 0.1
		$Camera2D.zoom.y -= 0.1
