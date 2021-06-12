extends Object
class_name sector_class

var virtual = true
var id:int
var ships = []

signal ship_enters(ship_id)
signal ship_leaves(ship_id)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func ship_leaves(ship_id):
	ships.erase(ship_id)
	emit_signal("ship_leaves", ship_id)

func ship_enters(ship_id):
	ships.append(ship_id)
	emit_signal("ship_enters", ship_id)

func serialize():
	virtual = true
	for element in ships:
		element.enabled = true

func deserialize():
	virtual = false
	for element in ships:
		element.enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
