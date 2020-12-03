extends CanvasLayer

var messagePlaying = false

var string0 = "Find the %s Needles" % str(Globals.gameplay["maxNeedles"])
var string1 = "Bring the Needles to the Med Station"
var string2 = "Synthesis Completed"

func _play_message(msg : int) -> void:
	if msg == 0:
		$Alert.text = string0
	elif msg == 1:
		$Alert.text = string1
	elif msg == 2:
		$Alert.text = string2
	else:
		return


func _on_Quit_pressed():
	get_tree().change_scene("res://scenes/GameIntroScreen.tscn")

func _on_Retry_pressed():
	get_tree().reload_current_scene()
