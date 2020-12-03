extends Node2D

onready var map_scene = preload("res://scenes/MainMap.tscn")
onready var player_scene = preload("res://scenes/Player.tscn")
onready var monster_scene = preload("res://scenes/Monster.tscn")
onready var needle_scene = preload("res://scenes/Needle.tscn")
onready var med_station_scene = preload("res://scenes/MedStation.tscn")

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initialize()

func _initialize() -> void:
	rng.randomize()
	var level = _spawn_level()
	var player = _spawn_player(level)
	_limit_camera(player, level)
	_spawn_monster()
	_spawn_objectives()

func _spawn_level() -> Node2D:
	var map = map_scene.instance()
	map.scale.x = Globals.variables["map_scale"]
	map.scale.y = Globals.variables["map_scale"]
	add_child(map)
	Globals.map_details["spawnNumArray"] = map.get_child(2).get_used_cells()
	Globals.map_details["spawnNumCount"] = Globals.map_details["spawnNumArray"].size() - 1
	return map

func _spawn_player(map : Node2D) -> Node2D:
	var player = player_scene.instance()
	player.position = coord_normalize(Vector2(7,32))
	player.scale = Vector2(1.75, 1.75)
	add_child(player)
	return player

func _limit_camera(player, level : Node2D) -> void:
	var usedRect: Rect2 = level.get_child(0).get_used_rect()
	var mapSize = coord_normalize(usedRect.size)
	player.get_child(0).set_limit(MARGIN_LEFT, 0)
	player.get_child(0).set_limit(MARGIN_TOP, 0)
	player.get_child(0).set_limit(MARGIN_RIGHT, mapSize.x - 48)
	player.get_child(0).set_limit(MARGIN_BOTTOM, mapSize.y - 48)

func _spawn_monster() -> Node2D:
	var monster = monster_scene.instance()
	var randPos = rng.randi_range(0, Globals.map_details["spawnNumCount"])
	monster.position = coord_normalize(Globals.map_details["spawnNumArray"][randPos])
	monster.scale = Vector2(1.5, 1.5)
	add_child(monster)
	return monster

func _spawn_objectives() -> void:
	var medStation = med_station_scene.instance()
	var randPos = rng.randi_range(0, Globals.map_details["spawnNumCount"])
	medStation.position = coord_normalize(Globals.map_details["spawnNumArray"][randPos])
	add_child(medStation)
	
	for i in range(Globals.gameplay["maxNeedles"]):
		var needle = needle_scene.instance()
		needle.rotation_degrees = (rng.randi_range(0, 360))
		randPos = rng.randi_range(0, Globals.map_details["spawnNumCount"])
		needle.position = coord_normalize(Globals.map_details["spawnNumArray"][randPos])
		add_child(needle)

#Takes tilemap coords and converts them to world coords
func coord_normalize(value : Vector2) -> Vector2:
	var output = Vector2((value.x * 32 * 3) + 48, (value.y * 32 * 3) + 48)
	return(output)
