extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_color():
	if material == load("res://shader_inversion.tres"):
		material = null
	else:
		material = load("res://shader_inversion.tres")


func _on_Button_button_up():
	var scene_name = "menu_main"
	var path = "res://Scenes/UI/{scene_name}.tscn".format({"scene_name":scene_name})
	get_tree().change_scene(path)
