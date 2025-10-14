extends Control


@onready var title_screen: Control = $title_screen
@onready var select_0: TextureRect = $title_screen/select0
@onready var select_1: TextureRect = $title_screen/select1
@onready var how_to_menu: Control = $how_to_menu
@onready var select_cd: Timer = $select_cd

const FROG_SELECTOR = preload("res://Assets/goal_frog_tile.png")


var in_how_to = false

func _ready() -> void:
	how_to_menu.visible = false

func _process(_delta: float) -> void:
	
	var move_up = Input.is_action_just_pressed("move_up")
	var move_down = Input.is_action_just_pressed("move_down")
	var select = Input.is_action_just_pressed("select")
	
	if !in_how_to:
		select_cd.start()
		if move_up:
			select_0.texture = FROG_SELECTOR
			select_1.texture = null
		elif move_down:
			select_0.texture = null
			select_1.texture = FROG_SELECTOR
			
		if select_0.texture == FROG_SELECTOR:
			if select:
				get_tree().change_scene_to_file("res://Scene/game.tscn")
		elif select_1.texture == FROG_SELECTOR:
			if select:
				title_screen.visible = false
				in_how_to = true
				how_to_menu.visible = true
				
	if in_how_to and select_cd.is_stopped():
		if select:
			select_cd.start()
			title_screen.visible = true
			in_how_to = false
			how_to_menu.visible = false
	
	
	
	
