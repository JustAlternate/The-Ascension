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
	activate = true

func desactivation():
	$AnimatedSprite.animation = "desactivate"
	activate = false

func _on_piege_horizontale_simple_body_entered(body):
	if body.name == "body" :
		body_in = true
		if activate:
			emit_signal("death")


func _on_piege_horizontale_simple_body_exited(body):
	if body.name == "body":
		body_in = false
