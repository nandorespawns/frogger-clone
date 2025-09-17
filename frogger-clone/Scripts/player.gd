extends Node2D

var tile_size = 16
var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $hurtbox

var animation_speed = 0.2
var moving = false
var must_respawn = false

var goal_entered = null


func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _physics_process(_delta: float) -> void:
	var areas = hurtbox.get_overlapping_areas()
	var is_on_lake = areas.size() > 0 and areas.all(func (i): return i.name == "Lake")
	var is_on_car = areas.size() > 0 and areas.all(func (i): return i.collision_layer == 4)
	var is_on_goal = areas.size() > 0 and areas.all(func(i): return i.name == "goal")
	
	
	if is_on_lake or is_on_car:
		respawn()
		
	if is_on_goal:
		respawn()
	

func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			if dir == "move_up":
				animated_sprite_2d.play("default_up")
			elif dir == "move_down":
				animated_sprite_2d.play("down")
			elif dir == "move_left":
				animated_sprite_2d.play("left")
			elif dir == "move_right":
				animated_sprite_2d.play("right")
			move(dir)

func move(dir):
	var tween = create_tween()
	
	tween.tween_property(self, "position",
	position + inputs[dir] * tile_size,
	animation_speed).set_trans(Tween.TRANS_LINEAR)
	
	moving = true
	await tween.finished
	moving = false

func respawn():
	must_respawn = true


func _on_hurtbox_area_shape_entered(_area_rid: RID, area: Area2D, area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == "goal":
		goal_entered = area_shape_index
		
