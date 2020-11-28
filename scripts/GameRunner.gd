extends Node2D

onready var map = load(Globals.asset_path["map"]).instance()
onready var player = load(Globals.asset_path["player"]).instance()
onready var monster = load(Globals.asset_path["monster"]).instance()
onready var needle_scene = preload("res://scenes/Needle.tscn")

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initialize()

func _initialize() -> void:
	randomize()
	var level = _spawn_level()
	_spawn_player(level)
	_spawn_monster()
	_spawn_objectives()

func _spawn_level() -> Node2D:
	map.scale.x = Globals.variables["map_scale"]
	map.scale.y = Globals.variables["map_scale"]
	add_child(map)
	Globals.map_details["spawnNumArray"] = map.get_child(2).get_used_cells()
	Globals.map_details["spawnNumCount"] = Globals.map_details["spawnNumArray"].size()
	return map


func _spawn_player(map : Node2D) -> Node2D:
	player.position = coord_normalize(Vector2(7,32))
	player.scale.x = 1.75
	player.scale.y = 1.75
	add_child(player)
	return player

func _spawn_monster() -> Node2D:
	#monster.position = Vector2(200, -200)
	var randPos = rng.randi_range(0, Globals.map_details["spawnNumCount"])
	monster.position = coord_normalize(Globals.map_details["spawnNumArray"][randPos])
	add_child(monster)
	return monster

func _spawn_objectives() -> void:
	for i in range(Globals.gameplay["maxNeedles"]):
		var needle = needle_scene.instance()
		needle.rotation_degrees = (rng.randi_range(0, 360))
		var randPos = rng.randi_range(0, Globals.map_details["spawnNumCount"])
		needle.position = coord_normalize(Globals.map_details["spawnNumArray"][randPos])
		add_child(needle)

#Takes tilemap coords and converts them to world coords
func coord_normalize(value : Vector2) -> Vector2:
	var output = Vector2((value.x * 32 * 3) + 48, (value.y * 32 * 3) + 48)
	return(output)
