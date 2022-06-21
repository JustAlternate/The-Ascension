extends Area2D

signal revive

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var body_in = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("playable"):
		body_in = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("playable"):
		body_in = false

func _input(event):
	if event.is_action_pressed("interact"):
		if body_in:
			get_tree().call_group("main","revive")



func change_color():
	if material == load("res://shader_inversion.tres"):
		material = null
	else:
		material = load("res://shader_inversion.tres")
