extends Object
class_name player_class

var current_room:int = 0
var peer_id:int
var host_sector:bool = false

func init(id):
	peer_id = id
