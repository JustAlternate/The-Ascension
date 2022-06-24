extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	$Credits.global_position.y -= 0.4

func _on_Button2_button_up():
	var scene_name = "menu_main"
	var path = "res://Scenes/UI/{scene_name}.tscn".format({"scene_name":scene_name})
	get_tree().change_scene(path)
