extends PanelContainer

func _ready():
	pass


func _on_Back_pressed():
	print("Going Back")
	get_tree().change_scene("res://scenes/GameIntroScreen.tscn")
