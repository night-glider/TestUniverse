extends Node2D
const ROOM_SIZE = 100

func _draw():
	var rooms_coords = []
	var rooms = []
	if Multiplayer.server:
		rooms_coords = Multiplayer.RoomManager.rooms_coords
		rooms = Multiplayer.RoomManager.rooms
	else:
		rooms_coords = Multiplayer.MapManager.rooms_coords
		rooms = Multiplayer.MapManager.rooms
	
	""" Рисование секторов"""
	var default_font = Control.new().get_font("font")
	for i in Global.ROOM_NUMBER:
		draw_rect( Rect2(rooms_coords[i], Vector2(ROOM_SIZE, ROOM_SIZE)), Color.white)
		
		draw_string(default_font, Vector2(rooms_coords[i].x, rooms_coords[i].y + 32), str(i), Color.black)
		if rooms[i][1] != -1:
			draw_line( Vector2(rooms_coords[i].x + ROOM_SIZE/2, rooms_coords[i].y), Vector2(rooms_coords[i].x + ROOM_SIZE/2, rooms_coords[i].y - 100), Color.white)
		if rooms[i][2] != -1:
			draw_line( Vector2(rooms_coords[i].x, rooms_coords[i].y + ROOM_SIZE/2), Vector2(rooms_coords[i].x-100, rooms_coords[i].y + ROOM_SIZE/2), Color.white)
	
	if not Multiplayer.server:
		return
	
	""" Рисование кораблей"""
	for element in Multiplayer.ShipManager.ships.values():
		var pos = rooms_coords[element.room_id] + Vector2(50, 50) + element.pos/20
		if element.enabled:
			draw_circle(pos, 10, Color.red)
		else:
			draw_circle(pos, 10, Color.gray)

func _process(delta):
	update()
