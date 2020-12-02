extends KinematicBody2D
class_name Player

onready var needleLabel = $HUD/PanelContainer2/HBoxContainer2/NeedleFraction

var velocity = Vector2(0,0)
var SPEED = Globals.variables["player_speed"]
var dead = false
var hasAllNeedes = false
var currentHealth = 0
var currentNeedles = 0
var maxNeedles = Globals.gameplay["maxNeedles"]

func _ready():
	_initialize()

func _initialize():
	dead = false
	hasAllNeedes = false
	currentHealth = Globals.gameplay["maxHealth"]
	needleLabel.text = "%s / %s" % [currentNeedles, maxNeedles]
	

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
	if not dead:
		if !moving:
			$AnimatedSprite.play("Idle")
			if $Audio.is_playing():
				$Audio.stop()
		if moving:
			$AnimatedSprite.play("Walk")
			if not $Audio.is_playing():
				$Audio.play()
		velocity = velocity.normalized() * SPEED
	else:
		$AnimatedSprite.play("Dying")
	
func _physics_process(delta):
	get_input()
	move_and_slide(velocity)

func _process(delta):
	$Position2D.look_at(get_global_mouse_position())

func _on_Area2D_body_entered(body):
	if body.is_in_group("monster"):
		currentHealth -= clamp(1, 0, Globals.gameplay["maxHealth"])
		$HUD/PanelContainer/HBoxContainer/ProgressBar.value = currentHealth
		if currentHealth == 0:
			dead = true
			$SelfLight.visible = false
			$Position2D/FlashLight.visible = false
			
	if body.is_in_group("Needle"):
		currentNeedles += 1
		needleLabel.text = "%s / %s" % [currentNeedles, maxNeedles]
		body.queue_free()
		if currentNeedles == maxNeedles:
			hasAllNeedes = true
			needleLabel.add_color_override("font_color", Color(0,1,0))
