extends Node2D

export var state = 1

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
