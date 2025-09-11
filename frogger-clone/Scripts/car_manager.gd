extends Node

var CAR = preload("res://Scene/car.tscn")

var default_x = 320
var default_x_left = -12
var default_y = 201
var car_separation_y = 16

var row_direction = {
	"left" : "left",
	"right": "right"
}

#array of dictionaries
var row_properties = [
	{
		"speed": 30,
		"spawn_timer_duration": 3,
		"spawn_point": "right",
		"timer": Timer.new()
	},
	{
		"speed": 50,
		"spawn_timer_duration": 2,
		"spawn_point": "left",
		"timer": Timer.new()
		
	},
	{	"speed": 30,
		"spawn_timer_duration": 1.5,
		"spawn_point": "right",
		"timer": Timer.new()
		
	},
	{	"speed": 45,
		"spawn_timer_duration": 1.5,
		"spawn_point": "left",
		"timer": Timer.new()
		
	},
	{	"speed": 60,
		"spawn_timer_duration": 4,
		"spawn_point": "right",
		"timer": Timer.new()
		
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
			var new_car = CAR.instantiate()
			new_car.position.y = default_y - (car_separation_y * row_index)
			new_car.speed = properties["speed"]
			
			
			if (properties["spawn_point"] == "right"):
				new_car.direction_picked = "left"
				new_car.position.x = default_x
				
			else:
				new_car.direction_picked = "right"
				new_car.position.x = default_x_left
			add_child(new_car)
			
			
			
			
		
		
	
