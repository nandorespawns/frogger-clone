extends Node

const PLAYER = preload("res://Scene/player.tscn")
var player = PLAYER.instantiate()

var player_spawn_x: int = 150
var player_spawn_y: int = 216
var tile_size = 16

func _ready() -> void:
	player.position.x = player_spawn_x
	player.position.y = player_spawn_y
	add_child(player)
	

func _process(_delta: float) -> void:
	respawn()

func respawn():
	if player.is_dead == true:
		player.position.x = player_spawn_x
		player.position.y = player_spawn_y
		player.position = player.position.snapped(Vector2.ONE * tile_size)
		player.position += Vector2.ONE * tile_size/2
		player.is_dead = false
