extends Object
class_name sector_class

var virtual = true
var id:int
var ships = []




func ship_leaves(ship_id:ship_class):
	ships.erase(ship_id)

func ship_enters(ship_id:ship_class):
	ships.append(ship_id)
	ship_id.enabled = virtual
	for element in Multiplayer.players:
		if id == element.current_room:
			Multiplayer.rpc_id(element.peer_id,"ship_enters_to_sector", ship_id.enabled, ship_id.room_id, ship_id.spd, ship_id.pos, ship_id.target, ship_id.gate_pos, ship_id.id)
	

func serialize():
	if virtual == true:
		return
	virtual = true
	for element in ships:
		element.enabled = true

func deserialize():
	if virtual == false:
		return
	virtual = false
	for element in ships:
		element.enabled = false

