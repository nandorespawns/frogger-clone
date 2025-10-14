extends Node

const TURTLE = preload("res://Scene/turtle.tscn")
const TURTLE_2 = preload("res://Scene/turtle_2.tscn")
const LOG = preload("res://Scene/log.tscn")
const LOGS_2 = preload("res://Scene/logs_2.tscn")
const LOGS_3 = preload("res://Scene/logs_3.tscn")
const CROC = preload("res://Scene/croc.tscn")
const CROC_2 = preload("res://Scene/croc_2.tscn")
const CROC_3 = preload("res://Scene/croc_3.tscn")
#From bottom to top, rows 1 and 4 are turtle rows, rest are log rows

var default_x_right = 340
var default_x_left = -50
var default_y_separation = 16
var default_y_position = 120


var row_direction = {
	"left": "left",
	"right": "right"
	}


var row_properties = [
	{
		"speed": 30,
		"spawn_timer_duration": 4,
		"spawn_point": "right",
		"instances": [
			{
				"type": TURTLE_2,
				"spawn_chance": 1	
			}
		],
		"timer": Timer.new()
	},
	{
		"speed": 50,
		"spawn_timer_duration": 2,
		"instances": [
			{
				"type": LOG,
				"spawn_chance": 1
			},
			{
				"type": CROC,
				"spawn_chance": 0.05
			}
		],	
		"spawn_point": "left",
		"timer": Timer.new()
		
	},
	{	"speed": 30,
		"spawn_timer_duration": 6,
		"instances": [
			{
			"type": LOGS_3,
			"spawn_chance": 1
			},
			{
			"type": CROC_3,
			"spawn_chance": 0.05
			}
		],
		"spawn_point": "right",
		"timer": Timer.new()
		
	},
	{	"speed": 45,
		"spawn_timer_duration": 3,
		"instances": [
			{
				"type": TURTLE,
				"spawn_chance": 1	
			}
		],
		"spawn_point": "left",
		"timer": Timer.new()
		
	},
	{	"speed": 60,
		"spawn_timer_duration": 4,
		"instances": [
			{
				"type": LOGS_2,
				"spawn_chance": 1
			},
			{
				"type": CROC_2,
				"spawn_chance": 0.05
			}
		],
		"spawn_point": "right",
		"timer": Timer.new()
		
	}
]


func _ready() -> void:
	for row_index in row_properties.size():
		var properties = row_properties[row_index]
		
		var instance_timer = properties["timer"]
		instance_timer.wait_time = properties["spawn_timer_duration"]
		instance_timer.one_shot = true
		add_child(instance_timer)


func _process(_delta: float) -> void:
	populate()
	
	

func populate():
	for row_index in row_properties.size():
		var properties = row_properties[row_index]
		
		var instance_timer = properties["timer"]

		if instance_timer.is_stopped():
			instance_timer.start()
			
			var instances = properties["instances"]
			
			var index = 0
			if instances.size() > 1:
				var chance = randf_range(0, 1)
				
				instances.sort_custom(
					func (a,b): return a["spawn_chance"] < b["spawn_chance"]
				)
				
				for i in range(instances.size()):
					if chance <= instances[i]["spawn_chance"]:
						index = i
						break
				
			var new_instance = instances[index]["type"].instantiate()
			new_instance.position.y = default_y_position - (default_y_separation * row_index)
			new_instance.speed = properties["speed"]
			
			
			if (properties["spawn_point"] == "right"):
				new_instance.direction_picked = "left"
				new_instance.position.x = default_x_right
				
			else:
				new_instance.direction_picked = "right"
				new_instance.position.x = default_x_left
			add_child(new_instance)
				
