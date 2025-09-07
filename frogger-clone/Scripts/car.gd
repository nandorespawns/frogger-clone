extends Node2D

var tile_size = 16
var speed: float

var direction = {
	"right": 0,
	"left": 0
}


@export var direction_picked: String

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	direction = {
		"right": speed,
		"left": -speed
	}
	

func _physics_process(delta: float) -> void:
	position.x += direction[direction_picked] * delta
	
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "dead_zone":
		queue_free()
