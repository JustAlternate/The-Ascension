extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal death

var body_in = false
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


func try_revive():
	if body_in and activate:
		get_tree().call_group("main","dont_revive")
##

func _on_piege_horizontale_simple_body_entered(body):
	if body.name == "body" :
		body_in = true
		if activate:
			get_tree().call_group("main","death")

func _on_piege_horizontale_simple_body_exited(body):
	if body.name == "body":
		body_in = false

func _on_Button_levier_activated():
	desactivation()

func _on_Button_levier_desactivated():
	activation()
