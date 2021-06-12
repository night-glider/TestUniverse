extends Node2D

const SHIP_COUNT = 100
var ships = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in SHIP_COUNT:
		ships.append(ship_class.new())
	
	for element in ships:
		element.init(round(rand_range(0,99)))
		element.pos = Vector2(rand_range(-1000,1000), rand_range(-1000,1000))


func _draw():
	for element in ships:
		var pos = RoomManager.rooms_coords[element.room_id] + Vector2(50, 50) + element.pos/20
		if element.enabled:
			draw_circle(pos, 10, Color.red)
		else:
			draw_circle(pos, 10, Color.gray)
		pass

func _process(delta):
	for element in ships:
		element.tick()
		pass
	update()
