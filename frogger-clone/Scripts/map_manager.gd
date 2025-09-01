extends Node


var test_map = preload("res://Scene/TestTileMap.tscn")


var current_tile_map = null

func _ready() -> void:
	var new_map = test_map.instantiate()
	add_child(new_map)
	current_tile_map = new_map
