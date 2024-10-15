extends CharacterBody2D

@onready var singleplayer: Node2D = $".."
var types = 2

func _process(delta):
	var ball_pos = $"../ball".position
	var main_pos = Vector2()
	var dist =  position.y - ball_pos.y
	var move
	if abs(dist) > 10:
		move =  singleplayer.speed * delta * (dist /abs(dist))
		position.y -= move
	move_and_slide()
	
func _close():
	queue_free()
