extends Area2D


var player_in_range = false
signal interacted(instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_range:
		if Input.is_action_just_pressed("interact"):
			print("BONJOUR AVENTURIER BIEN OU QUOI ?")
			emit_signal("interacted",self)


func _on_Bonhomme_body_entered(body):
	if body.is_in_group("playable"):
		player_in_range = true


func _on_Bonhomme_body_exited(body):
	if body.is_in_group("playable"):
		player_in_range = false
