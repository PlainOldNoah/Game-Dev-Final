extends Node

const DEFAULT_MASS: = 2.0
const DEFAULT_MAX_SPEED: = 200

# Called when the node enters the scene tree for the first time.
static func follow(
		vel: Vector2,
		global_position: Vector2,
		target_position: Vector2,
		max_speed: = DEFAULT_MAX_SPEED,
		mass: = DEFAULT_MASS
) -> Vector2:
	var desired_vel: = (target_position - global_position).normalized() * max_speed
	var steering: = (desired_vel - vel)/mass
	return vel + steering

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
