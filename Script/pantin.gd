extends KinematicBody2D


export var run_speed = 350
export var jump_speed = -1000
export var gravity = 2500

var velocity = Vector2.ZERO
var mort_velocity = 0
var pushing = null

export var actions = [[0.5,"r",true],[2.5,"r",false]]
export var spirit = false
var temps = 0
var stop = false

var right = false
var left = false
var jump = false

var alive = true

func _ready():
	velocity.x = 0
	velocity.y = 0
	if spirit:
		$AnimatedSprite.visible = false
		$AnimatedSprite2.visible = true

func get_input():
	if is_on_floor():
		$AnimatedSprite.play()
	
	velocity.x = 0


	if is_on_floor() and jump:
		velocity.y = jump_speed
	
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
	temps += delta
	do_actions()

func do_actions():
	if not stop:
		if len(actions) > 0:
			
			if actions[0][0]<temps:
				match actions[0][1]:
					"r":
						right = actions[0][2]
					"l":
						left = actions[0][2]
					"j":
						jump = actions[0][2]
					"s":
						stop = actions[0][2]
					"f":
						special(actions[0][2])
					_:
						print("attention analise d'action non comprise:\n",actions[0][1]," à ",actions[0][0])
				actions.pop_front()
				do_actions()


func special(variable):
	match variable:
		"coucou":
			pass


# Pour les bruits de pas
func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.animation == "course" and not spirit:
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

