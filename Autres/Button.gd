extends Button




func _on_Button_button_up():
	var path = "res://Scenes/main.tscn"
	get_tree().change_scene(path)
