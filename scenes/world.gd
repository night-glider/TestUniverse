extends Node2D

func _ready():
	var ship = preload("res://objects/enemy_ship.tscn")
	for element in RoomManager.sectors[Global.current_room].ships:
		var new_ship = ship.instance()
		new_ship.init_ship(element)
		add_child(new_ship)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
