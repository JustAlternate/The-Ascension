extends Area2D

signal pushed
signal unpushed
var pushed = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pushed:
		pass


func _on_Button_body_entered(body):
	if body.is_in_group("tangible") and pushed == 0:
		pushed += 1
		if pushed == 1:
			$AnimatedSprite.animation = "activation"
			$AnimatedSprite.frame = 0
			emit_signal("pushed")


func _on_Button_body_exited(body):
	if body.is_in_group("tangible"):
		pushed -= 1
		if pushed == 0:
			$AnimatedSprite.animation = "desactivation"
			$AnimatedSprite.frame = 0
			emit_signal("unpushed")
