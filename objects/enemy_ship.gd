extends Node2D

var room_id:int = 0
var spd:float = 1
var target:int = 0
var gate_pos:Vector2 = Vector2(0,0)
var global_ship_id


func init_ship(ship_id):
	global_ship_id = ship_id
	room_id = global_ship_id.room_id
	spd = global_ship_id.spd
	position = global_ship_id.pos
	target = global_ship_id.target
	gate_pos = global_ship_id.gate_pos
	if gate_pos == Vector2(0,0):
		OS.alert("ФАТАЛЬНАЯ ОШИБКА. У РЕАЛЬНОЙ КОПИИ ПОЗИЦИЯ ВРАТ НАХОДИТСЯ В ТОЧКЕ (0,0)")
	pass

func use_gate():
	global_ship_id.enabled = true
	queue_free()

func _process(delta):
	if position.distance_squared_to(gate_pos) < 1:
		use_gate()
		return
	position = position.move_toward(gate_pos, spd)
	global_ship_id.pos = position
