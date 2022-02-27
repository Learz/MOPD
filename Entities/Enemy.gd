extends KinematicBody2D
class_name Enemy

var hp = 100
var atk = 1
var cooldown = 5 #Attack cooldown (seconds)
var speed = 10

var _shape : CircleShape2D
var cooldown_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_shape = CircleShape2D.new()
	_shape.radius = 6
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown_counter = max(0, cooldown_counter-delta)
#	global_position = global_position.move_toward(Global.player.position, delta * speed)
	move_and_slide(global_position.direction_to(Global.player.position))
	
#	var query := Physics2DShapeQueryParameters.new()
#	query.set_shape(_shape)
#	query.collide_with_bodies = true
#	query.collide_with_areas = true
#	query.collision_layer = 1
#	query.transform = global_transform
#
#	var result := get_world_2d().direct_space_state.intersect_shape(query, 2)
#	if result:
#		if result[0]["collider"] == Global.player.collider and cooldown_counter <= 0:
#			Global.player.hurt(atk)
#			cooldown_counter = cooldown
#		else:
#			global_position -= (result[0]["collider"].global_position-global_position).normalized()*2
			
			
