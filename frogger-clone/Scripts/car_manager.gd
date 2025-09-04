extends Node

var CAR = preload("res://Scene/car.tscn")

var default_x = 312
var default_x_left = -8
var default_y = 201
var car_separation_y = 16

var row_direction = {
	"left" : "left",
	"right": "right"
}

func _ready() -> void:
	populate()
	

func populate():
	for row in range(5):
		var new_car = CAR.instantiate()
		new_car.position.y = default_y - (car_separation_y * row)
		add_child(new_car)
		if row == 0:
			new_car.direction_picked = row_direction["left"]
			new_car.position.x = default_x

			
		elif row == 1: 
			new_car.direction_picked = row_direction["right"]
			new_car.position.x = default_x_left

			
		elif row == 2:
			new_car.direction_picked = row_direction["left"]
			new_car.position.x = default_x
			
			
		elif row == 3:
			new_car.direction_picked = row_direction["right"]
			new_car.position.x = default_x_left
			
			
		elif row == 4:
			new_car.direction_picked = row_direction["left"]
			new_car.position.x = default_x
			
			
			
