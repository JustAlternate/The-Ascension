extends Node2D

export var state = 1

func _ready():
	change_state()
	change_state()

func change_state():
	if state == 1:
		state = 0
		$niveau/live.visible = false
		$niveau/dead.visible = true
		$niveau/Spirit.dead()
		$niveau/body.dead()
	else:
		state = 1
		$niveau/live.visible = true
		$niveau/dead.visible = false
		$niveau/Spirit.revive()
		$niveau/body.revive()

func _input(event):
	if event.is_action_pressed("test"):
		change_state()


func _on_piege_horizontale_simple_death():
	change_state()


func _on_Fontaine_revive():
	change_state()
