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
	$LeverSFX.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_body_entered(body):
	if body.is_in_group("playable"):
		entered = true

func _on_Button_body_exited(body):
	entered = false

func _input(event):
	if event.is_action_pressed("interact") and entered:
		$LeverSFX.play()
		if activated:
			activated = false
			$AnimatedSprite.animation = "switch_activation"
			$AnimatedSprite.frame = 0
			emit_signal("switch")
			emit_signal("desactivated")
		else:
			activated = true
			$AnimatedSprite.animation = "switch_desactivation"
			$AnimatedSprite.frame = 0
			emit_signal("switch")
			emit_signal("activated")
			
func change_color():
	if material == null:
		material = load("res://shader_inversion.tres")
	else:
		material = null


