extends Node

var gameplay = {
	"maxNeedles": 8,
	"currentNeedles" : 0,
	"maxHealth" : 3,
}

var map_details = {
	"mapSize" : null,
	"spawnNumCount" : null,
	"spawnNumArray" : null,
}

var variables = {
	"player_speed" : 500,
	"monster_speed" : 0.5, #monster speed equals this x player speed
	"map_scale" : 3,
}

var asset_path = {
	"player" : "res://scenes/Player.tscn",
	"monster" : "res://scenes/Monster.tscn",
	"map" : "res://scenes/MainMap.tscn",
	"needle" : "res://scenes/Needle.tscn"
	}
