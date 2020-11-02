extends KinematicBody2D

var speed = 2
onready var target = get_parent().get_node("HazmatEntity")
var vel = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var target_global_position: Vector2 = target.get_global_position()
	
	vel = Steering.follow(
		vel,
		global_position,
		target_global_position
	)
	
	vel = move_and_slide(vel)
	#set up to take input from user using IJKL, will be modified for pathing later
	#moves left when j key pressed, starts animation
	#if Input.is_key_pressed(KEY_J):
	#	self.position.x-=speed
	#	$AnimatedSprite.play("MonsterWalk")
	#	$AnimatedSprite.flip_h = true
		
	#moves right when l jey pressed, starts animation
	#elif Input.is_key_pressed(KEY_L):
	#	self.position.x+=speed
	#	$AnimatedSprite.play("MonsterWalk")
	#	$AnimatedSprite.flip_h = false
		
	#moves up when i key pressed, starts animation
	#elif Input.is_key_pressed(KEY_I):
	#	self.position.y-=speed
	#	$AnimatedSprite.play("MonsterWalk")
		
	#moves down when k key pressed, starts animation
	#elif Input.is_key_pressed(KEY_K):
	#	self.position.y+=speed
	#	$AnimatedSprite.play("MonsterWalk")
		
	#stops animation when no key is being pressed
	#else:
	#	$AnimatedSprite.frame = 0
		
