extends Object
class_name ship_class

var enabled:bool = true
var room_id:int = 0
var spd:float = 1
var pos:Vector2 = Vector2(0,0)
var target:int = 0
var gate_pos:Vector2 = Vector2(0,0)

func init(start_room_id:int):
	room_id = start_room_id
	RoomManager.sectors[room_id].ship_enters(self)
	init_instruction()
	pass

func use_gate():
	RoomManager.sectors[room_id].ship_leaves(self)
	room_id = RoomManager.rooms[room_id][target]
	RoomManager.sectors[room_id].ship_enters(self)
	
	match target:
		0:
			pos = Vector2(-1000, 0)
		1:
			pos = Vector2(0, 1000)
		2:
			pos = Vector2(1000, 0)
		3:
			pos = Vector2(0, -1000)

func init_instruction():
	var choice = [0, 1, 2, 3]
	choice.shuffle()
	for i in choice:
		if RoomManager.rooms[room_id][i] != -1:
			target = i
			match target:
				0:
					gate_pos = Vector2(1000, 0)
				1:
					gate_pos = Vector2(0, -1000)
				2:
					gate_pos = Vector2(-1000, 0)
				3:
					gate_pos = Vector2(0, 1000)
			return

func tick():
	if pos.distance_squared_to(gate_pos) < 1:
		use_gate()
		init_instruction()
	pos = pos.move_toward(gate_pos, spd)
	pass
