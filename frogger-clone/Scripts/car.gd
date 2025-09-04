extends Node2D

var tile_size = 16
@onready var movement_timer: Timer = $movement_timer
var direction = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT
}
var animation_speed = 6

@export var direction_picked: String

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _process(_delta: float) -> void:
	move_car()

func move_car():
	if movement_timer.is_stopped():
		movement_timer.start()
		var tween = create_tween()
		
		tween.tween_property(self, "position",
		position + direction[direction_picked] * tile_size,
		1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		
		#position += direction[direction_picked] * tile_size
		
		
	
	
