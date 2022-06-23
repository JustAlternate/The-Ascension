extends KinematicBody2D
class_name MovableBox

export var gravity = 500

var velocity = Vector2.ZERO
var was_on_floor = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity)
	velocity = Vector2.ZERO
	if is_on_floor():
		if not was_on_floor:
			print("atterri !")
			was_on_floor = true
	else:
		was_on_floor = false

func slide(vector):
	velocity.x = vector.x
