extends Node2D

export var state = 1

func _ready():
	change_state()
	change_state()

func change_state():
	if state == 1:
		state = 0
		$live.visible = false
		$dead.visible = true
		$Spirit.dead()
		$body.dead()
	else:
		state = 1
		$live.visible = true
		$dead.visible = false
		$Spirit.revive()
		$body.revive()

func _input(event):
	if event.is_action_pressed("test"):
		change_state()


func _on_piege_horizontale_simple_death():
	change_state()
