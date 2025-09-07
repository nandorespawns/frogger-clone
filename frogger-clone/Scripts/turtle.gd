extends Node2D

var tile_size = 16

var speed = 10

var direction = {
	"right": speed,
	"left": -speed
}

@export var direction_picked: String
@onready var hitbox: Area2D = $hitbox

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _physics_process(delta: float) -> void:
	position.x += direction[direction_picked] * delta
	
	var areas = hitbox.get_overlapping_areas()
	
	for area in areas:
		var player = area.get_parent()
		player.position.x += direction[direction_picked] * delta
	
