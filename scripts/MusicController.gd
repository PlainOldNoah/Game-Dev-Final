extends Node

var music = load("res://assets/audio/decay-by-kevin-macleod-from-filmmusic-io.wav")

func _ready():
	pass # Replace with function body.
func play_music():
	$Music.stream = music
	$Music.play()
func stop_music():
	$Music.stop()
