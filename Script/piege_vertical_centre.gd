extends Node2D


signal death

export var activate = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if activate:
		$AnimatedSprite.animation = "activate"
	else:
		$AnimatedSprite.animation = "desactivate"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activation():
	$AnimatedSprite.animation = "activate"
	$on.play()
	activate = true

func desactivation():
	$AnimatedSprite.animation = "desactivate"
	$off.play()
	activate = false

#groupe_fonction
func change_color():
	if material == load("res://shader_inversion.tres"):
		material = null
	else:
		material = load("res://shader_inversion.tres")


func _on_left_area_body_entered(body):
	if body.name == "body" and activate:
		body.mort_velocity =-500
		get_tree().call_group("main","death")
	elif body.is_in_group("destructible") and activate:
		body.detruire()


func _on_right_area_body_entered(body):
	if body.name == "body" and activate:
		get_tree().call_group("main","death")
		body.mort_velocity = 500
	elif body.is_in_group("destructible") and activate:
		body.detruire()
		
func _on_Button_levier2_activated():
	activation()

func _on_Button_levier2_desactivated():
	desactivation()
