extends CharacterBody2D

@onready var local_multiplayer: Node2D = $".."
var types = 2
var can_change = true

func _move():
	velocity.y = 0
	velocity.x = 0
	if Input.is_action_pressed("Down2"):
		velocity.y += local_multiplayer.speed
	if Input.is_action_pressed("Up2"):
		velocity.y -= local_multiplayer.speed
	if Input.is_action_pressed("Left2"):
		velocity.x -= local_multiplayer.speed
	if Input.is_action_pressed("Right2"):
		velocity.x += local_multiplayer.speed
	if velocity.x != 0 and velocity.y != 0:
		velocity.x /= sqrt(2)
		velocity.y /= sqrt(2)
	move_and_slide()

func _types():
	if Input.is_action_pressed("Small2") && types != 1:
		types = 1
		scale.y = 0.75;
		$Timer.start(10)
		can_change = false
	if Input.is_action_pressed("Normal2") && types != 2:
		types = 2
		scale.y = 1;
		$Timer.start(10)
		can_change = false
	if Input.is_action_pressed("Big2") && types != 3:
		types = 3
		scale.y = 1.25
		$Timer.start(10)
		can_change = false

func _types_time():
	if $Timer.get_time_left() != 0:
		var time :int = $Timer.get_time_left()
		$"../hub/typetimeP2".text = str(time + 1)
	else:
		$"../hub/typetimeP2".text = "READY"

func _process(delta):
	_move()
	if can_change == true:
		_types()
	_types_time()
	
func _set_can_change():
	can_change = true
	$Timer.stop()
	print("true")

func _on_timer_timeout():
	_set_can_change()

func _close():
	queue_free()
