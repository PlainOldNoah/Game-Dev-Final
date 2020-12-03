extends KinematicBody2D
class_name Player

onready var needleLabel = $HUD/PanelContainer2/HBoxContainer2/NeedleFraction

var velocity = Vector2(0,0)
var SPEED = Globals.variables["player_speed"]
var dead = false
var hasAllNeedes = false
var hittable = true
var currentHealth = 0
var currentNeedles = 0
var maxNeedles = Globals.gameplay["maxNeedles"]

func _ready():
	_initialize()
	$HUD._play_message(0)
	

func _initialize():
	dead = false
	hasAllNeedes = false
	hittable = true
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
		
	if Input.is_key_pressed(KEY_L):
		print_debug("RELOADING SCENE")
		get_tree().reload_current_scene()
	
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
	if body.is_in_group("monster") and hittable == true:
		currentHealth -= clamp(1, 0, Globals.gameplay["maxHealth"])
		$HUD/PanelContainer/VBoxContainer/HBoxContainer/ProgressBar.value = currentHealth
		hittable = false
		$DamageCooldown.start()
		if currentHealth == 0:
			dead = true
			$HUD/GameOverScreen.visible = true
	if body.is_in_group("Needle"):
		currentNeedles += 1
		needleLabel.text = "%s / %s" % [currentNeedles, maxNeedles]
		body.queue_free()
		if currentNeedles == maxNeedles:
			hasAllNeedes = true
			needleLabel.add_color_override("font_color", Color(0,1,0))
			$HUD._play_message(1)
	if body.is_in_group("MedStation") and hasAllNeedes == true:
		$HUD._play_message(2)
		$HUD/WinnerScene.visible = true
		dead = true

func _on_DamageCooldown_timeout():
	hittable = true
