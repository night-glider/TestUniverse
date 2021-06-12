extends Node2D

var ship = preload("res://objects/enemy_ship.tscn")

func _ready():
	RoomManager.sectors[Global.current_room].deserialize()
	RoomManager.sectors[Global.current_room].connect( "ship_enters", self, "ship_enters")
	for element in RoomManager.sectors[Global.current_room].ships:
		var new_ship = ship.instance()
		new_ship.init_ship(element)
		add_child(new_ship)


func ship_enters(ship_id):
	ship_id.enabled = false
	var new_ship = ship.instance()
	new_ship.init_ship(ship_id)
	add_child(new_ship)

func _process(delta):
	$CanvasLayer/Label.text = str(RoomManager.sectors[Global.current_room].ships)


func _on_Button_pressed():
	Global.current_room = $CanvasLayer/LineEdit.text.to_int()
	get_tree().change_scene("res://scenes/world.tscn")
