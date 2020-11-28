extends PanelContainer


func _ready():
	MusicController.play_music()
	pass
	
func _on_GameStart_pressed():
	print("Starting Game...")
	get_tree().change_scene("res://scenes/GameRunner.tscn")
	MusicController.stop_music()

func _on_Settings_pressed():
	print("Opening Settings")
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_Credits_pressed():
	print("Opening Credits")
	get_tree().change_scene("res://scenes/Credits.tscn")
