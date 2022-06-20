extends Node2D

export var state = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func change_state():
	if state == 1:
		state = 0
		$live.visible = false
		$dead.visible = true
		$Spirit.dead()
	else:
		state = 1
		$live.visible = true
		$dead.visible = false
		$Spirit.revive()

func _input(event):
	if event.is_action_pressed("test"):
		change_state()
