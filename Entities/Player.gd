extends Sprite
class_name Player

var hp = 100
var speed = 2

var _direction = Vector2(0,0)

onready var collider = $KinematicBody2D

func _input(event):
	pass
		

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	translate(_direction.clamped(1) * speed)

func hurt(var dmg):
	hp -= dmg
	Global.GUI.HP.text = str(hp)
