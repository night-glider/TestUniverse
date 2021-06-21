extends Node2D

var ROOM_NUMBER:int = 0
var current_room:int = 0

func change_sector(sector_id:int):
	current_room = sector_id
	get_tree().change_scene("res://scenes/world.tscn")
