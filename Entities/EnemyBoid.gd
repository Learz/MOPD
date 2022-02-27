class_name EnemyBoid

var rid : RID
var position := Vector2(0,0) 

var speed : int = 20
var HP : int = 100
var atk : int = 1
var cooldown = 5 #Attack cooldown (seconds)
var cooldown_counter = 0
