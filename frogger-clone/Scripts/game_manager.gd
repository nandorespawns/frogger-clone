extends Node

const PLAYER = preload("res://Scene/player.tscn")
var player = PLAYER.instantiate()

var player_spawn_x: int = 150
var player_spawn_y: int = 216
var tile_size = 16
var player_reset_travelled_y = 1000

const GOAL_FROG = preload("res://Scene/goal_frog.tscn")


var goal_array = [false, false, false, false, false]
var goal_position_x = 32.0
var goal_position_y = 39.5
var goal_separation_x = tile_size * 4

var is_game_over

@onready var score_num: Label = $score_num
@onready var frogs_rem_num: Label = $frogs_rem_num
@onready var time_bar: ProgressBar = $time_bar
@onready var timer: Timer = $Timer
@onready var highsore_num: Label = $highsore_num


const GAME_OVER = preload("res://Scene/game_over.tscn")
var game_over = GAME_OVER.instantiate()


func _ready() -> void:
	add_child(game_over)
	game_over.visible = false
	time_bar.max_value = timer.wait_time
	timer.start()
	
	player.position.x = player_spawn_x
	player.position.y = player_spawn_y
	add_child(player)
	
	player.died.connect(respawn)
	player.gain_walk_score.connect(score_by_move)
	

func _process(_delta: float) -> void:
	timer_tick()
	highscore_update()
	reset()
	



func respawn():
	
	player.position.x = player_spawn_x
	player.position.y = player_spawn_y
	player.position = player.position.snapped(Vector2.ONE * tile_size)
	player.position += Vector2.ONE * tile_size/2
	
	
	if player.goal_entered != null: 
		goal_update()
		player.goal_entered = null
		
		
	player.dead = false
	player.tween.kill()
	lose_live()
	player.moving = false
	player.total_travelled_y = player_reset_travelled_y


func goal_update():
	if goal_array[player.goal_entered]:
		return
	goal_array[player.goal_entered] = true
	
	var new_goal = GOAL_FROG.instantiate()
	new_goal.position.x = goal_position_x + (goal_separation_x * player.goal_entered)
	new_goal.position.y = goal_position_y
	add_child(new_goal)
	score_by_goal()
	#print(goal_array)


func lose_live():
	Global.frogs_remaining -= 1
	frogs_rem_num.text = str(Global.frogs_remaining)
	if Global.frogs_remaining < 0:
		game_lost()

func score_by_move():
	Global.score += 10
	score_num.text = str(Global.score)

func score_by_goal():
	Global.score += 400
	score_num.text = str(Global.score)
	
	
	timer.start(timer.time_left + 30) 
	time_bar.max_value = timer.wait_time

func timer_tick():
	time_bar.value = timer.time_left

func game_lost():
	get_tree().paused = true
	game_over.visible = true
	game_over.get_child(2).text = str(Global.score)
	game_over.get_child(4).text = str(Global.highscore)
	timer.paused = true
	is_game_over = true
	

func highscore_update():
	highsore_num.text = str(Global.highscore)

func reset():
	if is_game_over == true:
		var reset_game = Input.is_action_just_pressed("reset")
		if reset_game:
			print("ligma")
			get_tree().paused = false
			get_tree().change_scene_to_file("res://Scene/game.tscn")
			Global.frogs_remaining = 6
			Global.score = 0
			game_over.visible = false
			is_game_over = false
