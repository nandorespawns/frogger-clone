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
@onready var submerge_timer: Timer = $submerge_timer

const SUBMERGE_TIMER_RANGE = [3, 10]

func _ready() -> void:
	submerge_timer.start(randf_range(SUBMERGE_TIMER_RANGE[0], SUBMERGE_TIMER_RANGE[1])) 
	
	direction = {
		"right": speed,
		"left": -speed
	}
	
	if direction_picked == "right":
		animated_sprite_2d.flip_h = true
		animated_sprite_2d_2.flip_h = true

func _physics_process(delta: float) -> void:
	submerge_turtle()
	position.x += direction[direction_picked] * delta
	
	var areas = hitbox.get_overlapping_areas()
	
	for area in areas:
		if area.name == "hurtbox":
			var player = area.get_parent()
			player.position.x += direction[direction_picked] * delta
			
			
	

var is_turtle_under = false
func submerge_turtle():
	var random_num = randf_range(SUBMERGE_TIMER_RANGE[0], SUBMERGE_TIMER_RANGE[1])
	if submerge_timer.is_stopped():
		is_turtle_under = !is_turtle_under
		submerge_timer.start(2.66 if is_turtle_under else random_num)
		
		var animation_name = "under" if is_turtle_under else "default"
		
		for node in get_children().filter(func (node): return node is AnimatedSprite2D):
			node.play(animation_name)
			
		for h in hitbox.get_children():
			h.disabled = is_turtle_under


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "dead_zone":
		queue_free()
