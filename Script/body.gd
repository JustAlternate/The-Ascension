extends KinematicBody2D


export var run_speed = 350
export var jump_speed = -1000
export var gravity = 2500

var velocity = Vector2.ZERO

var alive = false

var sur_echelle = false

var top_collide = false
var bottom_collide = false
var top_body

func _ready():
	velocity.x = 0
	velocity.y = 0

func get_input():
	if alive:
		
		if sur_echelle:
			$AnimatedSprite.animation = "echelle"
			
		
		if is_on_floor():
			$AnimatedSprite.play()
		
		velocity.x = 0
		var right = Input.is_action_pressed("move_right")
		var left = Input.is_action_pressed("move_left")
		var jump = Input.is_action_just_pressed("move_up")

		if sur_echelle and Input.is_action_pressed("move_up"):
			velocity.y = -100

		if is_on_floor() and jump:

			velocity.y = jump_speed
			if not sur_echelle:
				$AnimatedSprite.animation = 'saut'
		
		elif right:
			
			velocity.x += run_speed
			if not sur_echelle:
				$AnimatedSprite.animation = "course"
				if $AnimatedSprite.flip_h == true:
					$AnimatedSprite.flip_h = false
			
			if not is_on_floor():
				$AnimatedSprite.frame = 4
				$AnimatedSprite.stop()
		
		elif left:
			
			velocity.x -= run_speed
			if not sur_echelle:
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



func _on_Echelle_montage_echelle():
	print('tu veux echelle')
	sur_echelle = true

func _on_Echelle_pas_echelle():
	print('tu veux pas echelle')
	sur_echelle = false

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
	if not sur_echelle:
		velocity.y += gravity * delta
	else:
		velocity.y = 0
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

