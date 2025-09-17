extends Node

const CAR = preload("res://Scene/car.tscn")
const CAR_2 = preload("res://Scene/car_2.tscn")
const CAR_3 = preload("res://Scene/car_3.tscn")
const CAR_4 = preload("res://Scene/car_4.tscn")

var default_x = 320
var default_x_left = -50
var default_y = 201
var car_separation_y = 16

var row_direction = {
	"left" : "left",
	"right": "right"
}

#array of dictionaries
var row_properties = [
	{
		"speed": 0, #30
		"spawn_timer_duration": 3,
		"spawn_point": "right",
		"timer": Timer.new(),
		"instance": CAR
	},
	{
		"speed": 0,#50
		"spawn_timer_duration": 2,
		"spawn_point": "left",
		"timer": Timer.new(),
		"instance": CAR_2
		
	},
	{	"speed": 0, #30
		"spawn_timer_duration": 1.5,
		"spawn_point": "right",
		"timer": Timer.new(),
		"instance": CAR_3
		
	},
	{	"speed": 0, #45
		"spawn_timer_duration": 1.5,
		"spawn_point": "left",
		"timer": Timer.new(),
		"instance": CAR
		
	},
	{	"speed": 0,#100
		"spawn_timer_duration": 4,
		"spawn_point": "right",
		"timer": Timer.new(),
		"instance": CAR_4
	}
]

func _ready() -> void:
	for row_index in row_properties.size():
		var properties = row_properties[row_index]
		
		var car_timer = properties["timer"]
		car_timer.wait_time = properties["spawn_timer_duration"]
		car_timer.one_shot = true
		add_child(car_timer)
	

func _process(_delta: float) -> void:
	populate()
	

func populate():
	for row_index in row_properties.size():
		var properties = row_properties[row_index]
		
		var car_timer = properties["timer"]

		if car_timer.is_stopped():
			car_timer.start()
			var new_car = properties["instance"].instantiate()
			new_car.position.y = default_y - (car_separation_y * row_index)
			new_car.speed = properties["speed"]
			
			
			if (properties["spawn_point"] == "right"):
				new_car.direction_picked = "left"
				new_car.position.x = default_x
				
			else:
				new_car.direction_picked = "right"
				new_car.position.x = default_x_left
			add_child(new_car)
			
			
			
			
		
		
	
