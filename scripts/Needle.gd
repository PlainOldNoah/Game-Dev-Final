extends Area2D


func _on_Needle_body_entered(body):
	if body.is_in_group("player"):
		Globals.gameplay["currentNeedles"] += 1
		print_debug(Globals.gameplay["currentNeedles"],"/",Globals.gameplay["maxNeedles"])
		self.queue_free()
