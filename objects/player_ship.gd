extends Node2D

var room_id = 0



func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation_degrees-=1
	if Input.is_action_pressed("ui_right"):
		rotation_degrees+=1
	if Input.is_action_pressed("ui_up"):
		position+=Vector2.RIGHT.rotated(rotation)*10
