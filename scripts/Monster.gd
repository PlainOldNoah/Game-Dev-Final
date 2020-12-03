extends KinematicBody2D

var speed = Globals.variables["player_speed"] * Globals.variables["monster_speed"]
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
	
	if vel.x < 0:
		$AnimatedSprite.flip_h = true
	if vel.x > 0:
		$AnimatedSprite.flip_h = false
	
