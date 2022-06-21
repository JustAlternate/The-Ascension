extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal death

var body_in = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_piege_horizontale_simple_body_entered(body):
	if body.name == "body":
		body_in = true
		emit_signal("death")


func _on_piege_horizontale_simple_body_exited(body):
	if body.name == "body":
		body_in = false
