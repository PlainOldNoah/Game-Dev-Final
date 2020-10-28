extends Node2D


onready var player_scene = preload("res://scenes/Player.tscn")
onready var monster_scene = preload("res://scenes/Monster.tscn")
var SCALE = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = player_scene.instance()
	player.position = Vector2(100, 100)
	player.scale.x = SCALE
	player.scale.y = SCALE
	add_child(player)
	
	var monster = monster_scene.instance()
	add_child(monster)
