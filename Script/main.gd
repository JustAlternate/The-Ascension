extends Node2D

signal change_color
export var state = 1 # 0 = dead, 1 = alive
var backup_position 

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
		get_tree().call_group("grp_change_color","change_color")
		
	else:
		state = 1
		$niveau/live.visible = true
		$niveau/dead.visible = false
		$niveau/Spirit.revive()
		$niveau/body.revive()
		get_tree().call_group("grp_change_color","change_color")

func revive():
	if state == 0:
		backup_position = $niveau/Spirit.global_position
		change_state()
		get_tree().call_group("grp_piege","try_revive")

func dont_revive():
	change_state()
	$niveau/Spirit.global_position = backup_position
	

func death():
	if state == 1:
		change_state()

func _input(event):
	if event.is_action_pressed("test"):
		change_state()


func _on_piege_horizontale_simple_death():
	change_state()
