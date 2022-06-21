extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	$Sprite.position.y -= 1

func _on_Button_button_up():
	var map_name = "niveau_1"
	var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
	get_tree().change_scene(path)
	
func _on_Button3_button_up():
	get_tree().quit()
