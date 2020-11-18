extends Node2D

var SCALE = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	var map = load(Globals.asset_path["map"]).instance()
	map.scale.x = Globals.variables["map_scale"]
	map.scale.y = Globals.variables["map_scale"]
	add_child(map)
	
	var player = load(Globals.asset_path["player"]).instance()
	player.position = Vector2(500, 500)
	player.scale.x = SCALE
	player.scale.y = SCALE
	add_child(player)
	
	var monster = load(Globals.asset_path["monster"]).instance()
	monster.position = Vector2(200, -200)
	add_child(monster)
