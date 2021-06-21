extends Node2D

var room_id:int = 0
var spd:float = 1
var target:int = 0
var gate_pos:Vector2 = Vector2(0,0)
var global_ship_id


func init_ship(ship_id):
	global_ship_id = ship_id.id
	room_id = ship_id.room_id
	spd = ship_id.spd
	position = ship_id.pos
	target = ship_id.target
	gate_pos = ship_id.gate_pos
	if gate_pos == Vector2(0,0):
		OS.alert("ФАТАЛЬНАЯ ОШИБКА. У РЕАЛЬНОЙ КОПИИ ПОЗИЦИЯ ВРАТ НАХОДИТСЯ В ТОЧКЕ (0,0)")
	pass

func use_gate():
	Multiplayer.rpc_id(Multiplayer.server_peer, "ship_leaves_sector", true, room_id, spd, position, target, gate_pos, global_ship_id)
	queue_free()

func _process(delta):
	if position.distance_squared_to(gate_pos) < 10:
		position = gate_pos
		use_gate()
		return
	look_at(gate_pos)
	position+=Vector2.RIGHT.rotated(rotation)*spd
