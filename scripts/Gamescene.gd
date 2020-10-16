extends Node2D

onready var player_scene = preload("res://scenes/Player.tscn")

func _ready():
	var player = player_scene.instance()
	add_child(player)
