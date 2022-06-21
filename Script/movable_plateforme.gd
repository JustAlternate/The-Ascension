extends Node2D

signal path_finished

export var vitesse = 50

var direction = 0 #0=ne bouge pas, 1 = vers l'arrivée, -1 = vers le départ

var etat = 1 # 1: à l'arrivé, -1: au départ, si la plateforme est en mouvement donne l'emplacement de départ 


# Called when the node enters the scene tree for the first time.
func _ready():
	$plateforme.global_position = $"départ".global_position


func _physics_process(delta):
	if direction!=0:
		$plateforme.global_position += ($"arrivé".global_position - $"départ".global_position)*direction*delta*vitesse/100
		if $"départ".global_position.distance_to($"arrivé".global_position) < $"départ".global_position.distance_to($plateforme.global_position) and direction==1:
			emit_signal("path_finished")
			$plateforme.global_position = $"arrivé".global_position
			direction = 0
		elif $"départ".global_position.distance_to($"arrivé".global_position) < $"arrivé".global_position.distance_to($plateforme.global_position) and direction==-1:
			emit_signal("path_finished")
			$plateforme.global_position = $"départ".global_position
			direction = 0



func _on_movable_plateforme_path_finished():
	print("finished")
