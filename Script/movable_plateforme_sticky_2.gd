extends Node2D

signal path_finished

export var vitesse = 50
export var choose_collision_layer = 1

export var direction = 0 #0=ne bouge pas, 1 = vers l'arrivée, -1 = vers le départ
var linear_velocity
var etat = 1 # 1: à l'arrivée, -1: au départ, si la plateforme est en mouvement donne l'emplacement de départ 
var movable_things:Array
var dif

# Called when the node enters the scene tree for the first time.
func _ready():
	print((choose_collision_layer))
	$plateforme.set_collision_layer(choose_collision_layer)
	$plateforme.set_collision_mask(choose_collision_layer)
	$plateforme.global_position = $"départ".global_position
	dif = $enfant.global_position - $plateforme.global_position


func _physics_process(delta):
	
	if direction!=0:
		linear_velocity=($"arrivée".global_position - $"départ".global_position)*direction*delta*vitesse/100
		$plateforme.global_position += linear_velocity 

		"""
		for thing in movable_things:
			thing.global_position += linear_velocity
			"""
		
		if $"départ".global_position.distance_to($"arrivée".global_position) < $"départ".global_position.distance_to($plateforme.global_position) and direction==1:
			emit_signal("path_finished")
			$plateforme.global_position = $"arrivée".global_position
			direction = 0
			
		elif $"départ".global_position.distance_to($"arrivée".global_position) < $"arrivée".global_position.distance_to($plateforme.global_position) and direction==-1:
			emit_signal("path_finished")
			$plateforme.global_position = $"départ".global_position
			direction = 0
		$enfant.global_position = $plateforme.global_position + dif

func _on_movable_plateforme_path_finished():
	pass

func move_forward():
	direction = 1

func move_backward():
	direction = -1

func change_color():
	if material == load("res://shader_inversion.tres"):
		material = null
	else:
		material = load("res://shader_inversion.tres")


func _on_Area2D_body_entered(body):
	if body.is_in_group("boxable"):
		movable_things.append(body)


func _on_Area2D_body_exited(body):
	if body in movable_things:
		movable_things.erase(body)
