extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_fin_body_entered(body):
	if body.name == "body":
		GlobalVariables.current_level = 0
		var map_name = "credits"
		var next_scene = preload("res://Scenes/UI/credits.tscn")
		get_tree().change_scene_to(next_scene)
