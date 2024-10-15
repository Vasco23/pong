extends Node2D

var score = Vector2 (0, 0)
var speed = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Leave"):
		get_tree().change_scene_to_file("res://menu.tscn")
	if score.x == 7 or score.y == 7:
		$ball._close()
		$player_1._close()
		$player_2._close()
		$meio.queue_free()
		$hub/time.text = ""
		if score.x == 7:
			$"hub/winlose window".text = "PLAYER 1 WON"
		if score.y == 7:
			$"hub/winlose window".text = "PLAYER 2 WON"
		$"hub/winlose window/windowtime".start(3)
		score.x = 0
		score.y = 0


func _on_leftgoal_body_entered(body):
	if (body == $"ball"):
		score.y += 1
		$"hub/result player2".text = str(score.y)
		$start_ball.start(3)

func _on_rightgoal_body_entered(body):
	if (body == $"ball"):
		score.x += 1
		$"hub/result player".text = str(score.x)
		$start_ball.start(3)

func _back_to_menu():
	print("back to menu")
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_windowtime_timeout():
	_back_to_menu()

	
