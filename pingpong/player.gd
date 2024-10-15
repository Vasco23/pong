extends CharacterBody2D

@onready var singleplayer: Node2D = $".."
var types = 2
var can_change = true

func _move():
	velocity.y = 0
	velocity.x = 0
	if Input.is_action_pressed("Down"):
		velocity.y += singleplayer.speed
	if Input.is_action_pressed("Up"):
		velocity.y -= singleplayer.speed
	if Input.is_action_pressed("Left"):
		velocity.x -= singleplayer.speed
	if Input.is_action_pressed("Right"):
		velocity.x += singleplayer.speed
	if velocity.x != 0 and velocity.y != 0:
		velocity.x /= sqrt(2)
		velocity.y /= sqrt(2)
	move_and_slide()
	
func _types():
	if Input.is_action_pressed("Small") && types != 1:
		types = 1
		scale.y = 0.75
		$change_type_timer.start(10)
		print("false")
		can_change = false
	elif Input.is_action_pressed("Normal") && types != 2:
		types = 2
		scale.y = 1
		$change_type_timer.start(10)
		can_change = false
	elif Input.is_action_pressed("Big") && types != 3:
		types = 3
		scale.y = 1.25
		$change_type_timer.start(10)
		can_change = false

func _types_time():
	if $change_type_timer.get_time_left() != 0:
		var time :int = $change_type_timer.get_time_left()
		$"../hub/type timeP1".text = str(time + 1)
	else:
		$"../hub/type timeP1".text = "READY"

func _process(delta):
	_move()
	if can_change == true:
		_types()
	_types_time()
	

func _set_can_change():
	$change_type_timer.stop()
	print("true")
	can_change = true

func _on_change_type_timer_timeout():
	_set_can_change()
	
func _close():
	queue_free()
	
