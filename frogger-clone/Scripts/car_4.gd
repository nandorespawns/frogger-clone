extends Node2D

var tile_size = 16
var speed: float
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2

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
	
	if direction_picked == "right":
		var temp_position = animated_sprite_2d.position
		animated_sprite_2d.position = animated_sprite_2d_2.position
		animated_sprite_2d_2.position = temp_position
		
		animated_sprite_2d.flip_h = true
		animated_sprite_2d_2.flip_h = true
	

func _physics_process(delta: float) -> void:
	position.x += direction[direction_picked] * delta
	
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "dead_zone":
		queue_free()
