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
@onready var ray_cast_2d: RayCast2D = $RayCast2D

var animation_speed = 0.2
var moving = false
var must_respawn = false

var goal_entered = null

var dead = false
signal died

var current_y
var previous_y 
var total_travelled_y = 1000
signal gain_walk_score 

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _physics_process(_delta: float) -> void:
	
	if !dead:
		var areas = hurtbox.get_overlapping_areas()
		var is_on_lake = areas.size() > 0 and areas.all(func (i): return i.name == "Lake")
		var is_on_car = areas.size() > 0 and areas.all(func (i): return i.collision_layer == 4)
		var is_on_goal = areas.size() > 0 and areas.all(func(i): return i.name == "goal")
		var is_out_of_bounds = areas.size() > 0 and areas.any(func(i): return i.name == "Out_of_bounds")
		
		
		if is_on_lake or is_on_car or is_out_of_bounds:
			dead = true
			died.emit()
			
			
		if is_on_goal:
			died.emit()
			
		

	

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
			

var tween
func move(dir):
	
	ray_cast_2d.target_position = inputs[dir] * tile_size
	ray_cast_2d.force_raycast_update()
	if !ray_cast_2d.is_colliding():
		tween = create_tween()
		
		
		var current_platform_direction = 0
		var areas = hurtbox.get_overlapping_areas()
		for area in areas:
			if area.collision_layer == 2:
				var platform = area.get_parent()
				current_platform_direction = platform.direction[platform.direction_picked] 
				
				
			
		
		
		tween.tween_property(self, "position",
		position + inputs[dir] * tile_size + Vector2.RIGHT * current_platform_direction * animation_speed,
		animation_speed).set_trans(Tween.TRANS_LINEAR)
		
		previous_y = position.y
		#print("previous", previous_y)
		moving = true
		await tween.finished
		current_y = position.y
		#print("current", current_y)
		#print("total", total_travelled_y)
		moving = false
		
		
		if previous_y > current_y and current_y < total_travelled_y:
			total_travelled_y = current_y
			gain_walk_score.emit()
			
		
	


func _on_hurtbox_area_shape_entered(_area_rid: RID, area: Area2D, area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == "goal":
		goal_entered = area_shape_index
		
