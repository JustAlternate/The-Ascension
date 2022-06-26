extends KinematicBody2D


export var run_speed = 350
export var jump_speed = -1000
export var gravity = 2500
export var vitesse_dechelage:int = 50

var velocity = Vector2.ZERO
var mort_velocity = 0
var pushing = []
var interact
var alive = false

var sur_echelle = false

var top_collide = 0
var bottom_collide = 0
var top_body

func _ready():
	velocity.x = 0
	velocity.y = 0

func get_input():
	if alive:
		
		if sur_echelle and not is_on_floor():
			$AnimatedSprite.animation = "echelle"
			
		
		if is_on_floor():
			$AnimatedSprite.play()
		
		velocity.x = 0
		var right = Input.is_action_pressed("move_right")
		var left = Input.is_action_pressed("move_left")
		var jump = Input.is_action_just_pressed("move_up")
		
		if sur_echelle and Input.is_action_pressed("move_up"):
			velocity.y = -vitesse_dechelage

		if is_on_floor() and jump:

			velocity.y = jump_speed
			if not sur_echelle:
				$AnimatedSprite.animation = 'saut2'
		
		elif right:
			
			velocity.x += run_speed
			if not sur_echelle:
				if not pushing.empty() and interact:
					$AnimatedSprite.animation = "pousse"
				else:
					$AnimatedSprite.animation = "course"
					if $AnimatedSprite.flip_h == true:
						$AnimatedSprite.flip_h = false
						$pousse/CollisionShape2D.position.x = 420
				
				if not is_on_floor():
					$AnimatedSprite.frame = 4
					$AnimatedSprite.stop()
		
		elif left:
			
			velocity.x -= run_speed
			if not sur_echelle:
				if not pushing.empty() and interact:
					$AnimatedSprite.animation = "pousse"
				else:
					$AnimatedSprite.animation = "course"
					if $AnimatedSprite.flip_h == false:
						$AnimatedSprite.flip_h = true
						$pousse/CollisionShape2D.position.x = -420
			
				if not is_on_floor():
					$AnimatedSprite.frame = 4
					$AnimatedSprite.stop()
			
		elif is_on_floor() and not ( not pushing.empty() and interact) :
			$AnimatedSprite.animation = "idle"
		elif not pushing.empty() and interact:
			$AnimatedSprite.animation = "pousse"
	else:
		pass

func _on_Echelle_montage_echelle():
	sur_echelle = true
	$AnimatedSprite.play()
	

func _on_Echelle_pas_echelle():
	sur_echelle = false

# Pour l'instant permet de pousser la boîte
func kinematic_physics():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is MovableBox:
			collision.collider.slide(-collision.normal * (run_speed / 2))
			
	if top_collide > 0 and bottom_collide > 0:
		get_tree().call_group("main","death")
		if top_body!=null:
			top_body.pouf()

func move_box():
	interact = Input.is_action_pressed("interact")
	if interact and not pushing.empty():
		for box in pushing:
			box.move_and_slide(velocity, Vector2(0, -1))


func _physics_process(delta):
	if not sur_echelle:
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	get_input()
	kinematic_physics()
	move_box()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	velocity.x *= 0.9 #pour le repoussage de mort



func dead():
	if $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	$DeathSoundEffect.play()
	$AnimatedSprite.animation = "mort"
	alive = false
	velocity = Vector2.ZERO
	velocity.x = mort_velocity
	mort_velocity = 0


func revive():
	alive = true
	velocity = Vector2.ZERO


# booléens pour savoir si le joueur risque d'être écrasé

func _on_bottom_area_entered(_area):
	bottom_collide += 1
	
func _on_bottom_body_entered(body):
	if body != self:
		bottom_collide += 1
		
func _on_bottom_area_exited(_area):
	bottom_collide -= 1
func _on_bottom_body_exited(body):
	if body != self:
		bottom_collide -= 1
		
		
func _on_top_area_entered(area):
	if area.is_in_group("area_tue"):
		top_collide += 1
func _on_top_body_entered(body):
	if body != self and body.is_in_group("body_tue"):
		top_collide += 1
		if body.is_in_group("boxable"):
			top_body = body
			
func _on_top_area_exited(area):
	if area.is_in_group("area_tue"):
		top_collide -= 1
func _on_top_body_exited(body):
	if body != self and body.is_in_group("body_tue"):
		top_collide -= 1
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



func _on_pousse_body_entered(body):
	if body.is_in_group("boxable"):
		pushing.append(body)




func _on_pousse_body_exited(body):
	if body.is_in_group("boxable"):
		pushing.erase(body)
