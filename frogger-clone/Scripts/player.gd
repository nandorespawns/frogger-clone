extends Node2D

var tile_size = 16
var inputs = {"move_right": Vector2.RIGHT,
			"move_left": Vector2.LEFT,
			"move_up": Vector2.UP,
			"move_down": Vector2.DOWN}

@onready var ray: RayCast2D = $RayCast2D

var animation_speed = 6
var moving = false

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2


func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = create_tween()
		
		tween.tween_property(self, "position",
		position + inputs[dir] * tile_size,
		1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		
		moving = true
		await tween.finished
		moving = false


func _on_hurtbox_area_entered(_area: Area2D) -> void:
	print("detected")
