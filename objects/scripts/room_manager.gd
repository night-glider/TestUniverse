extends Node2D

const ROOM_NUMBER:int = 100
const ROOM_SIZE:int = 100
var rooms = []
var sectors = []
var rooms_coords = []
var free_pool = []
var rand = RandomNumberGenerator.new()

func _ready():
	for i in ROOM_NUMBER:
		sectors.append(sector_class.new())
		sectors[i].id = i


func create_room(room_id):
	var index = choose_target()
	var vec = free_pool[index]
	rooms_coords[room_id] = vec
	free_pool.remove(index)
	var right = Vector2(vec.x + ROOM_SIZE * 2, vec.y)
	var left = Vector2(vec.x - ROOM_SIZE * 2, vec.y)
	var up = Vector2(vec.x, vec.y - ROOM_SIZE * 2)
	var down = Vector2(vec.x, vec.y + ROOM_SIZE * 2)
	
	if not(right in free_pool) and not(right in rooms_coords):
		free_pool.append(right)
		
	if not(left in free_pool) and not(left in rooms_coords):
		free_pool.append(left)
		
	if not(up in free_pool) and not(up in rooms_coords):
		free_pool.append(up)
		
	if not(down in free_pool) and not(down in rooms_coords):
		free_pool.append(down)

func check_free(vec:Vector2):
	var right = Vector2(vec.x + ROOM_SIZE * 2, vec.y)
	var left = Vector2(vec.x - ROOM_SIZE * 2, vec.y)
	var up = Vector2(vec.x, vec.y - ROOM_SIZE * 2)
	var down = Vector2(vec.x, vec.y + ROOM_SIZE * 2)
	var cnt = 0
	if not left in rooms_coords:
		cnt+=1
	if not right in rooms_coords:
		cnt+=1
	if not up in rooms_coords:
		cnt+=1
	if not down in rooms_coords:
		cnt+=1
	return cnt

func choose_target()->int:
	
	if rand.randi_range(0,1) == 0:
		return rand.randi_range(0,min(10, free_pool.size()-1))
	else:
		return rand.randi_range(max(0, (free_pool.size()-1)-10), (free_pool.size()-1))

func generate():
	rooms.clear()
	rooms_coords.clear()
	free_pool.clear()
	for i in ROOM_NUMBER:
		rooms.append([-1,-1,-1,-1])
		rooms_coords.append(Vector2())
	
	rooms_coords[0] = Vector2(100,100)
	free_pool.append(Vector2(rooms_coords[0].x + ROOM_SIZE * 2, rooms_coords[0].y))
	free_pool.append(Vector2(rooms_coords[0].x - ROOM_SIZE * 2, rooms_coords[0].y))
	free_pool.append(Vector2(rooms_coords[0].x, rooms_coords[0].y + ROOM_SIZE * 2))
	free_pool.append(Vector2(rooms_coords[0].x, rooms_coords[0].y - ROOM_SIZE * 2))
	
	for i in range(1, ROOM_NUMBER):
		create_room(i)
	
	var vec: Vector2
	for i in ROOM_NUMBER:
		vec = rooms_coords[i]
		var right = rooms_coords.find(Vector2(vec.x + ROOM_SIZE * 2, vec.y))
		var left = rooms_coords.find(Vector2(vec.x - ROOM_SIZE * 2, vec.y))
		var up = rooms_coords.find(Vector2(vec.x, vec.y - ROOM_SIZE * 2))
		var down = rooms_coords.find(Vector2(vec.x, vec.y + ROOM_SIZE * 2))
		
		if right > -1:
			rooms[i][0] = right
		
		if up > -1:
			rooms[i][1] = up
			
		if left > -1:
			rooms[i][2] = left
			
		if down > -1:
			rooms[i][3] = down

func _process(delta):
	for element in sectors:
		element.serialize()
	for element in Multiplayer.players:
		sectors[element.current_room].deserialize()
