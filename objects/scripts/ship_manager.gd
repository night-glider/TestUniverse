extends Node2D

const SHIP_COUNT = 100
var ships = {}


func generate():
	
	for i in SHIP_COUNT:
		var new_ship = ship_class.new()
		new_ship.init(round(rand_range(0,99)))
		new_ship.pos = Vector2(rand_range(-1000,1000), rand_range(-1000,1000))
		ships[new_ship.id] = new_ship


func _process(delta):
	if not Multiplayer.server:
		return
	for element in ships.values():
		element.tick()
		pass
