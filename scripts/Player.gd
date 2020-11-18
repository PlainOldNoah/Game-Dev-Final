extends KinematicBody2D

var velocity = Vector2(0,0)
var SPEED = 200
var Mouse_Position

func get_input():
	velocity = Vector2()
	var moving = false
	
	# WASD Movement
	# Flips direction of sprite based on key and normalizes speed
	if Input.is_key_pressed(KEY_A):
		velocity.x -= 1
		$AnimatedSprite.flip_h = false
		moving = true
	if Input.is_key_pressed(KEY_D):
		velocity.x += 1
		$AnimatedSprite.flip_h = true
		moving = true
	if Input.is_key_pressed(KEY_W):
		velocity.y -= 1
		moving = true
	if Input.is_key_pressed(KEY_S):
		velocity.y += 1
		moving = true
	
	# Runs Walk and Idle animation and sound depending on if sprite is moving
	if !moving:
		$AnimatedSprite.play("Idle")
		if $Audio.is_playing():
			$Audio.stop()
	if moving:
		$AnimatedSprite.play("Walk")
		if not $Audio.is_playing():
			$Audio.play()
	velocity = velocity.normalized() * SPEED
	
func _physics_process(delta):
	get_input()
	move_and_slide(velocity)

func _process(delta):
	#Mouse_Position = get_local_mouse_position()
	$Position2D.look_at(get_global_mouse_position())
