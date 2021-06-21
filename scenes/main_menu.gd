extends Node2D

func _on_Button_pressed():
	Global.ROOM_NUMBER = 100
	var room_manager = preload("res://objects/server objects/room_manager.tscn").instance()
	var ship_manager = preload("res://objects/server objects/ship_manager.tscn").instance()
	get_node("/root").add_child(room_manager)
	get_node("/root").add_child(ship_manager)
	Multiplayer.RoomManager = room_manager
	Multiplayer.ShipManager = ship_manager
	Multiplayer.RoomManager.generate()
	Multiplayer.ShipManager.generate()
	Multiplayer.server_create()
	#get_tree().change_scene("res://scenes/main_scene.tscn")
	Global.change_sector(0)


func _on_Button2_pressed():
	var map_manager = preload("res://objects/server objects/room_manager.tscn").instance()
	get_node("/root").add_child(map_manager)
	Multiplayer.MapManager = map_manager

	Multiplayer.server_connect($LineEdit.text)
	#get_tree().change_scene("res://scenes/main_scene.tscn")
	Global.change_sector(0)
