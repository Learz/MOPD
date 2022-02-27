extends Control
class_name GUI

onready var HP = $LabelHP


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.GUI = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LabelFPS.text = str(Engine.get_frames_per_second())
	$LabelEnemyCount.text = str(Global.level.enemies.size())
