extends PanelContainer


func _ready():
	$Decay.play()
	pass
	
func _on_GameStart_pressed():
	print("Starting Game...")
	get_tree().change_scene("res://scenes/GameRunner.tscn")

func _on_Settings_pressed():
	print("Opening Settings")
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_Credits_pressed():
	print("Opening Credits")
	get_tree().change_scene("res://scenes/Credits.tscn")
