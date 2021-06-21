extends Node2D

var ship = preload("res://objects/enemy_ship.tscn")

func _ready():
	#Multiplayer.server_peer
	Multiplayer.rpc_id(1, "require_collection_of_ships_from_sector", Global.current_room)

func ship_enters(ship_id):
	ship_id.enabled = false
	var new_ship = ship.instance()
	new_ship.init_ship(ship_id)
	add_child(new_ship)

func _on_Button_pressed():
	Global.change_sector($CanvasLayer/LineEdit.text.to_int())
