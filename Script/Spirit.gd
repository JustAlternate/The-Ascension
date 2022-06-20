extends KinematicBody2D

var velocity = Vector2.ZERO
var input_velocity = Vector2.ZERO
export var speed = 500
export var acceleration = 0.1
export var friction = 0.05

var _on_fontaine = false
var alive = true

func get_input():
	input_velocity = Vector2.ZERO
	if alive:
		pass
	else:
		if Input.is_action_pressed("move_up"):
			input_velocity.y -= 1
		if Input.is_action_pressed("move_down"):
			input_velocity.y += 1
		if Input.is_action_pressed("move_left"):
			input_velocity.x -= 1
		if Input.is_action_pressed("move_right"):
			input_velocity.x += 1
		input_velocity = input_velocity.normalized() * speed
	
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity,acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO,friction)




# revivre/mourire
func dead():
	alive = false
	visible = true
	
func revive():
	velocity = Vector2.ZERO
	alive = true
	visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if alive:
		global_position = get_tree().current_scene.get_node("body").global_position
	else:
		get_input()
		move_and_slide(velocity)

