extends Node2D

var tile_size = 16

var direction = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT
}

#animation_speed is the amount of time it takes to move across 1 tile
var animation_speed = 0.5


@export var direction_picked: String

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	

func _process(_delta: float) -> void:
	move_car()

func move_car():

	var tween = create_tween()
	
	tween.tween_property(
		self,
		"position",
		position + direction[direction_picked] * (tile_size),
		animation_speed
	).set_trans(Tween.TRANS_LINEAR)
		
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "dead_zone":
		queue_free()
