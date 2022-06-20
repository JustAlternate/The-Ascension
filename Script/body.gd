extends KinematicBody2D


export var run_speed = 350
export var jump_speed = -1000
export var gravity = 2500

var velocity = Vector2.ZERO

var alive = false


func _ready():
	velocity.x = 0
	velocity.y = 0

func get_input():
	if alive:
		velocity.x = 0
		var right = Input.is_action_pressed("move_right")
		var left = Input.is_action_pressed("move_left")
		var jump = Input.is_action_just_pressed("move_up")

		if is_on_floor() and jump:
			velocity.y = jump_speed
		if right:
			velocity.x += run_speed
		if left:
			velocity.x -= run_speed
	else:
		velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))

func dead():
	alive = false
	velocity = Vector2.ZERO


func revive():
	alive = true
	velocity = Vector2.ZERO

