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
		
		if is_on_floor():
			$AnimatedSprite.play()
		
		velocity.x = 0
		var right = Input.is_action_pressed("move_right")
		var left = Input.is_action_pressed("move_left")
		var jump = Input.is_action_just_pressed("move_up")

		if is_on_floor() and jump:
			velocity.y = jump_speed
			$AnimatedSprite.animation = 'saut'
		
		elif right:
			
			velocity.x += run_speed
			$AnimatedSprite.animation = "course"
			if $AnimatedSprite.flip_h == true:
				$AnimatedSprite.flip_h = false
			
			if not is_on_floor():
				$AnimatedSprite.frame = 4
				$AnimatedSprite.stop()
		
		elif left:
			
			velocity.x -= run_speed
			$AnimatedSprite.animation = "course"
			if $AnimatedSprite.flip_h == false:
				$AnimatedSprite.flip_h = true
			
			if not is_on_floor():
				$AnimatedSprite.frame = 4
				$AnimatedSprite.stop()
		
		elif is_on_floor():
			$AnimatedSprite.animation = "idle"
		
	else:
		velocity = Vector2.ZERO

# Pour l'instant permet de pousser la boîte
func kinematic_physics():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is MovableBox:
			collision.collider.slide(-collision.normal * (run_speed / 2))


func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	kinematic_physics()
	velocity = move_and_slide(velocity, Vector2(0, -1))

func dead():
	alive = false
	velocity = Vector2.ZERO


func revive():
	alive = true
	velocity = Vector2.ZERO

