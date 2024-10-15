extends CharacterBody2D

var dir = Vector2(0,0)
var ball_speed = 500
var added_speed = 50
var max_speed = 2000
var min_speed = 200

func spawn_ball():
	ball_speed = 200
	position.x = 965
	position.y = randi_range(300, (1080 - 300))
	while dir.x == 0:
		dir.x  = -1
		continue
	dir.y = randf_range(-1, 1)
	velocity = dir * ball_speed
	velocity.normalized()
	$"../start_ball".stop()

func add_speed(speed):
	if ball_speed + speed < 200 or ball_speed + speed > 2000:
		return
	else:
		ball_speed += speed
		
func bounceop(collider):
	var balldir = (((position.y - collider.position.y) / 100) * 2)
	dir.y = balldir
	dir.x = -dir.x
	if collider.types == 1:
		added_speed = 150
	if collider.types == 2:
		added_speed = 50
	if collider.types == 3:
		added_speed = -50
	add_speed(added_speed)
		
func _physics_process(delta):
	var collision = move_and_collide(dir * ball_speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		if collider == $"../player_1" or collider == $"../bot" or collider == $"../player_2":
			bounceop(collider)
		if collider == $"../walls":
			dir.y = -dir.y
	if $"../start_ball".get_time_left() > 0:
		var time :int = $"../start_ball".get_time_left()
		$"../hub/time".text = str(time + 1)
	else:
		$"../hub/time".text = ""

func _close():
	queue_free()

func _ready():
	spawn_ball()

func _on_start_ball_timeout():
	spawn_ball()
