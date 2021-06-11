extends Node2D

const ROOM_NUMBER:int = 200
const ROOM_SIZE:int = 100
var rooms = []
var rooms_coords = []
var free_pool = []
var rand = RandomNumberGenerator.new()

func _ready():
	rand.randomize()
	generate()
	
func _draw():
	var default_font = Control.new().get_font("font")
	for i in ROOM_NUMBER:
		draw_rect( Rect2(rooms_coords[i], Vector2(ROOM_SIZE, ROOM_SIZE)), Color.white)
		
		draw_string(default_font, Vector2(rooms_coords[i].x, rooms_coords[i].y + 32), str(i), Color.black)
		if rooms[i][1] != -1:
			draw_line( Vector2(rooms_coords[i].x + ROOM_SIZE/2, rooms_coords[i].y), Vector2(rooms_coords[i].x + ROOM_SIZE/2, rooms_coords[i].y - 100), Color.white)
		if rooms[i][2] != -1:
			draw_line( Vector2(rooms_coords[i].x, rooms_coords[i].y + ROOM_SIZE/2), Vector2(rooms_coords[i].x-100, rooms_coords[i].y + ROOM_SIZE/2), Color.white)
	

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		$Camera2D.position.y -=10
	if Input.is_action_pressed("ui_down"):
		$Camera2D.position.y +=10
	if Input.is_action_pressed("ui_left"):
		$Camera2D.position.x -=10
	if Input.is_action_pressed("ui_right"):
		$Camera2D.position.x +=10
	if Input.is_action_pressed("ui_accept"):
		$Camera2D.zoom.x += 0.1
		$Camera2D.zoom.y += 0.1
	if Input.is_action_pressed("ui_cancel"):
		$Camera2D.zoom.x -= 0.1
		$Camera2D.zoom.y -= 0.1
	
	
	generate()
	update()
	
	pass

func create_room(room_id):
	var index = rand.randi_range(0, free_pool.size()-1)
	var vec = free_pool[index]
	rooms_coords[room_id] = vec
	if check_free(vec) < 3:
		create_room(room_id)
		return
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
		
