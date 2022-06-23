extends KinematicBody2D


export var run_speed = 350
export var jump_speed = -1000
export var gravity = 2500

var velocity = Vector2.ZERO

var alive = false

var top_collide = false
var bottom_collide = false
var top_body

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
		pass

# Pour l'instant permet de pousser la boîte
func kinematic_physics():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is MovableBox:
			collision.collider.slide(-collision.normal * (run_speed / 2))
			
	if top_collide and bottom_collide:
		dead()
		if top_body!=null:
			top_body.pouf()



func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	kinematic_physics()
	velocity = move_and_slide(velocity, Vector2(0, -1))


func dead():
	if $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	$DeathSoundEffect.play()
	$AnimatedSprite.animation = "mort"
	alive = false
	velocity = Vector2.ZERO


func revive():
	alive = true
	velocity = Vector2.ZERO


# booléens pour savoir si le joueur risque d'être écrasé

func _on_bottom_area_entered(area):
	bottom_collide = true
func _on_bottom_body_entered(body):
	if body != self:
		bottom_collide = true
func _on_bottom_area_exited(area):
	bottom_collide = false
func _on_bottom_body_exited(body):
	if body != self:
		bottom_collide = false
func _on_top_area_entered(area):
	top_collide = true
func _on_top_body_entered(body):
	if body != self:
		top_collide = true
		if body.is_in_group("boxable"):
			top_body = body
func _on_top_area_exited(area):
	top_collide = false
func _on_top_body_exited(body):
	if body != self:
		top_collide = false
		if body.is_in_group("boxable"):
			top_body = null


# Pour les bruits de pas
func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.animation == "course":
		match $AnimatedSprite.frame:
			0, 6:
				var rand = (randi() % 5) + 1
				match rand:
					1:
						$StepSoundEffects/step1.play()
					2:
						$StepSoundEffects/step2.play()
					3:
						$StepSoundEffects/step3.play()
					4:
						$StepSoundEffects/step4.play()
					5:
						$StepSoundEffects/step5.play()
