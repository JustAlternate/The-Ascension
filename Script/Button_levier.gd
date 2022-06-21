extends Area2D

var activated = false
var entered = false

signal switch
signal activated
signal desactivated
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_body_entered(body):
	entered = true

func _on_Button_body_exited(body):
	entered = false

func _input(event):
	if event.is_action_pressed("interact") and entered:
		if activated:
			emit_signal("switch")
			emit_signal("desactivated")
		else:
			emit_signal("switch")
			emit_signal("activated")
