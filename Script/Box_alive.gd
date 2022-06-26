extends KinematicBody2D
class_name MovableBox

export var gravity = 500
export var resurection_node_path:NodePath
export var vitesse_resurection = 0.5
export var box_skin = "0"

onready var resurection_node = get_node(resurection_node_path)


var velocity = Vector2.ZERO
var was_on_floor = false
var poufing=0
var pouf_force = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = box_skin


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity)
	if poufing > 0:
		poufing -= delta
		velocity.y += -300 * poufing
		velocity.x = pouf_force * poufing
	velocity = move_and_slide(velocity)
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

func pouf():
	poufing=2
	if (randi()%2 < 1):
		pouf_force = rand_range(30,50) 
	else: 
		pouf_force = -rand_range(30,50)


func detruire():
	$CPUParticles2D.emitting = true
	yield(get_tree().create_timer(0.5),"timeout")
	global_position = Vector2(-100,-100)
	yield(get_tree().create_timer(vitesse_resurection),"timeout")
	global_position = resurection_node.global_position
	$AnimatedSprite.animation = str(randi()%5)
	
	
