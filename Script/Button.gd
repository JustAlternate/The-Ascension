extends Area2D


var pushed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pushed:
		pass


func _on_Button_body_entered(body):
	if body.is_in_group("tangible"):
		pushed = true


func _on_Button_body_exited(body):
	if body.is_in_group("tangible"):
		pushed = false
