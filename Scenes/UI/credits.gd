extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	$Credits.global_position.y -= 1

func _on_Button2_button_up():
	var next_scene = preload("res://Scenes/UI/menu_main.tscn")
	get_tree().change_scene_to(next_scene)
