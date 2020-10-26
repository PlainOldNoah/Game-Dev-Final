extends Node2D

onready var player_scene = preload("res://scenes/Player.tscn")
onready var monster_scene = preload("res://scenes/Monster.tscn")

func _ready():
	var player = player_scene.instance()
	add_child(player)
	var monster = monster_scene.instance()
	add_child(monster)
