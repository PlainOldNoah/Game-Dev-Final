extends PanelContainer


func _ready():
	$Decay.play()
	pass
	
func _on_GameStart_pressed():
	get_tree().change_scene("res://scenes/GameRunner.tscn")

func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")

func _on_Credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")

func _on_Quit_pressed():
	get_tree().quit()
