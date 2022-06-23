extends KinematicBody2D
class_name MovableBox

export var gravity = 500

var velocity = Vector2.ZERO
var was_on_floor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity,Vector2(0, -1))
	velocity = Vector2.ZERO
	play_fall_sound()

func play_fall_sound():
	if is_on_floor():
		if not was_on_floor:
			$FallSFX.play()
		was_on_floor = true
	else:
		was_on_floor = false

func slide(vector):
	velocity.x = vector.x
