extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_fin_body_entered(body):
	if body.name == "body":
		GlobalVariables.current_level = 6
		var map_name = "niveau_6"
		var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
		get_tree().change_scene(path)

