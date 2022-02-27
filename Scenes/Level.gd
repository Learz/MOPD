extends Node2D
class_name Level

var enemies = []
var _shape : CircleShape2D
var query : Physics2DShapeQueryParameters
#const SPRITE_POOL_SIZE = 3000
#var spritePool = []
#var skelly = preload("res://Entities/Skeleton.tscn")

var collision_thread : Thread

# Run here and exit.
# The argument is the userdata passed from start().
# If no argument was passed, this one still needs to
# be here and it will be null.
func _thread_function(none):
	while true:
		for enemy in enemies:
			for check_enemy in enemies:
				check_enemy = check_enemy as EnemyBoid
				if enemy.position.distance_to(check_enemy.position) < _shape.radius:
					enemy.position -= (check_enemy.position-enemy.position).normalized()

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_thread = Thread.new()
#	collision_thread.start(self, "_thread_function")
	
	_shape = CircleShape2D.new()
	_shape.radius = 32
	
	query = Physics2DShapeQueryParameters.new()
	query.set_shape(_shape)
	query.collide_with_bodies = true
	query.collide_with_areas = true
	query.collision_layer = 1
	
	Global.level = self
#	for i in SPRITE_POOL_SIZE:
#		var instance = skelly.instance()
#		instance.visible = false
#		instance.set_process(false)
#		spritePool.append(instance)
#		add_child(instance)

func _physics_process(delta):
	for enemy_index in enemies.size():
		var enemy = enemies[enemy_index] as EnemyBoid
		if enemy.cooldown_counter <= 0:
			enemy.position = enemy.position.move_toward(Global.player.global_position, delta * enemy.speed)
		enemy.cooldown_counter -= delta
		
		var xform = Transform2D().translated(enemy.position)
		VisualServer.canvas_item_set_transform(enemy.rid, xform)
		
		query.transform = xform.translated(Vector2(16,16))

		var result := get_world_2d().direct_space_state.intersect_shape(query, 2)
		if result:
			if result[0]["collider"] == Global.player.collider:
				if enemy.cooldown_counter <= 0:
					Global.player.hurt(enemy.atk)
					enemy.cooldown_counter = enemy.cooldown
				enemy.position -= (result[0]["collider"].global_position-enemy.position).normalized()*2
		
#		for check_enemy in enemies:
#			check_enemy = check_enemy as EnemyBoid
#			if enemy.position.distance_to(check_enemy.position) < _shape.radius:
#				enemy.position -= (check_enemy.position-enemy.position).normalized()

# Thread must be disposed (or "joined"), for portability.
func _exit_tree():
	collision_thread.wait_to_finish()
