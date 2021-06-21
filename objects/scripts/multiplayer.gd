extends Node2D

var server = true
var server_peer
var players = []
""" серверные синглтоны """
var RoomManager:Node2D
var ShipManager:Node2D
var ServerGlobals:Node2D

""" клиентские синглтоны """
var MapManager:Node2D


func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")

func server_create():
	var peer = NetworkedMultiplayerENet.new()
	peer.always_ordered = false
	peer.transfer_mode = NetworkedMultiplayerPeer.TRANSFER_MODE_UNRELIABLE
	peer.create_server(6969, 10)
	get_tree().network_peer = peer
	server = true
	server_peer = get_tree().get_network_unique_id()
	var plr = player_class.new()
	plr.init(get_tree().get_network_unique_id())
	players.append(plr)

func server_connect(ip:String):
	var peer = NetworkedMultiplayerENet.new()
	peer.always_ordered = false
	peer.transfer_mode = NetworkedMultiplayerPeer.TRANSFER_MODE_UNRELIABLE
	peer.create_client(ip, 6969)
	get_tree().network_peer = peer
	server = false
	var plr = player_class.new()
	plr.init(get_tree().get_network_unique_id())
	players.append(plr)



""" Функции, обрабатываемые сервером"""
remotesync func require_collection_of_ships_from_sector(sector_id:int):
	var sender = get_tree().get_rpc_sender_id()
	for s in RoomManager.sectors[sector_id].ships:
		rpc_id(sender,"ship_enters_to_sector", s.enabled, s.room_id, s.spd, s.pos, s.target, s.gate_pos, s.id)

remotesync func player_update(current_room):
	var sender = get_tree().get_rpc_sender_id()
	for element in players:
		if element.peer_id == sender:
			element.current_room = current_room

remotesync func ship_leaves_sector(enabled:bool, room_id:int, spd:float, pos:Vector2, target:int, gate_pos:Vector2, id):
	var ship = ShipManager.ships.get(id)
	ship.enabled = true
	ship.room_id = room_id
	ship.spd = spd
	ship.pos = pos
	ship.target = target
	ship.gate_pos = gate_pos
	OS.alert(str(ship.enabled) + ", " + str(ship.room_id))
	ship.tick()
	OS.alert(str(ship.enabled) + ", " + str(ship.room_id))

""" Функции, обрабатываемые клиентом """
remote func update_map(room_number, rooms, rooms_coords, server):
	Global.ROOM_NUMBER = room_number
	MapManager.rooms = rooms
	MapManager.rooms_coords = rooms_coords
	server_peer = server

remotesync func ship_enters_to_sector(enabled:bool, room_id:int, spd:float, pos:Vector2, target:int, gate_pos:Vector2, id):
	var new_ship = ship_class.new()
	new_ship.enabled = enabled
	new_ship.room_id = room_id
	new_ship.spd = spd
	new_ship.pos = pos
	new_ship.target = target
	new_ship.gate_pos = gate_pos
	new_ship.id = id
	get_node("/root/sector").ship_enters(new_ship)

func _player_connected(id):
	var new_player = player_class.new()
	new_player.init(id)
	players.append(new_player)
	if server:
		rpc_id(id, "update_map", Global.ROOM_NUMBER, RoomManager.rooms, RoomManager.rooms_coords, server_peer)

func debug_info()->String:
	var result = "server:" + str(server) + "\nserver_peer:" + str(server_peer) + "\nPlayers:"
	for element in players:
		result+="[" + str(element.current_room) + "|" + str(element.peer_id) + "|" + str(element.host_sector) + "]"
	return result

func _process(delta):
	if server_peer != null:
		rpc_unreliable("player_update", Global.current_room)
