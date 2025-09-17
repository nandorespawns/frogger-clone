extends Node

const PLAYER = preload("res://Scene/player.tscn")
var player = PLAYER.instantiate()

var player_spawn_x: int = 150
var player_spawn_y: int = 216
var tile_size = 16


const GOAL_FROG = preload("res://Scene/goal_frog.tscn")


var goal_array = [false, false, false, false, false]
var goal_position_x = 32.0
var goal_position_y = 39.5
var goal_separation_x = tile_size * 4

func _ready() -> void:
	player.position.x = player_spawn_x
	player.position.y = player_spawn_y
	add_child(player)
	
	

func _process(_delta: float) -> void:
	respawn()

func respawn():
	if player.must_respawn == true:
		player.position.x = player_spawn_x
		player.position.y = player_spawn_y
		player.position = player.position.snapped(Vector2.ONE * tile_size)
		player.position += Vector2.ONE * tile_size/2
		if player.goal_entered != null: 
			goal_update()
			player.goal_entered = null
		player.must_respawn = false
		
func goal_update():
	if goal_array[player.goal_entered]:
		return
	goal_array[player.goal_entered] = true
	
	var new_goal = GOAL_FROG.instantiate()
	new_goal.position.x = goal_position_x + (goal_separation_x * player.goal_entered)
	new_goal.position.y = goal_position_y
	add_child(new_goal)
	print(goal_array)
