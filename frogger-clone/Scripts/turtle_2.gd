extends Node2D

var tile_size = 16

var speed: float

var direction = {
	"right": 0,
	"left": 0
}

@export var direction_picked: String
@onready var hitbox: Area2D = $hitbox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var animated_sprite_2d_3: AnimatedSprite2D = $AnimatedSprite2D3

func _ready() -> void:

	
	direction = {
		"right": speed,
		"left": -speed
	}
	
	if direction_picked == "right":
		animated_sprite_2d.flip_h = true
		animated_sprite_2d_2.flip_h = true
		animated_sprite_2d_3.flip_h = true

func _physics_process(delta: float) -> void:
	position.x += direction[direction_picked] * delta
	
	var areas = hitbox.get_overlapping_areas()
	
	for area in areas:
		if area.name == "hurtbox":
			var player = area.get_parent()
			player.position.x += direction[direction_picked] * delta



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "dead_zone":
		queue_free()
