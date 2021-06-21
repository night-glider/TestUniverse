extends Object
class_name ship_class

var enabled:bool = true
var room_id:int = 0
var spd:float = 1
var pos:Vector2 = Vector2(0,0)
var target:int = 0
var gate_pos:Vector2 = Vector2(0,0)
var id

func init(start_room_id:int):
	id = get_instance_id()
	room_id = start_room_id
	Multiplayer.RoomManager.sectors[room_id].ship_enters(self)
	init_instruction()
	pass

func use_gate():
	gate_pos = Vector2(0,0)
	Multiplayer.RoomManager.sectors[room_id].ship_leaves(self)
	room_id = Multiplayer.RoomManager.rooms[room_id][target]
	if room_id < 0:
		OS.alert("ФАТАЛЬНАЯ ОШИБКА. КОРАБЛЬ ПЕРЕМЕСТИЛСЯ В НЕБЫТИЕ. В СЕКТОР С ИНДЕКСОМ -1")
	match target:
		0:
			pos = Vector2(-1000, 0)
		1:
			pos = Vector2(0, 1000)
		2:
			pos = Vector2(1000, 0)
		3:
			pos = Vector2(0, -1000)
	init_instruction()
	Multiplayer.RoomManager.sectors[room_id].ship_enters(self)

func init_instruction():
	var choice = [0, 1, 2, 3]
	choice.shuffle()
	for i in choice:
		if Multiplayer.RoomManager.rooms[room_id][i] != -1:
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
	OS.alert("ФАТАЛЬНАЯ ОШИБКА. НЕ УДАЛОСЬ НАЙТИ ВРАТА В СЕКТОРЕ.")

func tick():
	if not enabled:
		return
	if gate_pos == Vector2(0,0):
		OS.alert("ФАТАЛЬНАЯ ОШИБКА. ПОЗИЦИЯ ВРАТ НАХОДИТСЯ В ТОЧКЕ (0,0)" + str(room_id))
	if pos.distance_squared_to(gate_pos) < 1:
		use_gate()
	pos = pos.move_toward(gate_pos, spd)
	pass
