extends Node2D

export var spawn_rate = 1.0 # How often enemies to spawn enemies (seconds)
export var spawn_limit = 1000

var enemy_type = preload("res://Entities/Enemy.tscn")

var texture = load("res://assets/Sprites/Enemies.png")

var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer = (timer + delta)
	if timer >= spawn_rate and Global.level.enemies.size() <= spawn_limit:
		timer = 0
		spawn()
		spawn()
		spawn()
		spawn()

func spawn():
	var instance = EnemyBoid.new()
	
	instance.rid = VisualServer.canvas_item_create()
	# Make this node the parent.
	VisualServer.canvas_item_set_parent(instance.rid, get_canvas_item())
	# Draw a texture on it.
	# Remember, keep this reference.
	# Add it, centered.
	VisualServer.canvas_item_add_texture_rect_region(
		instance.rid, 
		Rect2(Vector2(0,0), Vector2(32,32)), 
		texture, 
		Rect2(Vector2(0,0), Vector2(16,16))
		)
	
	VisualServer.canvas_item_set_modulate(instance.rid, Color(1,0.4,0.4))
	
	instance.position = Vector2((Global.level.enemies.size()%64)*16,floor(Global.level.enemies.size()/64)*16)
	var xform = Transform2D().translated(instance.position)
	VisualServer.canvas_item_set_transform(instance.rid, xform)
	
	Global.level.enemies.append(instance)
#	var instance : Enemy = enemy.instance()
#	add_child(instance)
#	instance.global_position = global_position
		
