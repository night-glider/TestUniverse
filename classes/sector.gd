extends Object
class_name sector_class

var id:int
var ships = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func ship_leaves(ship_id):
	ships.erase(ship_id)

func ship_enters(ship_id):
	ships.append(ship_id)

func serialize():
	for element in ships:
		element.enabled = true

func deserialize():
	for element in ships:
		element.enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
