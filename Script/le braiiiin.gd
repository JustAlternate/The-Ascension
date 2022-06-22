extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("playable"):
		$ColorRect.visible=false
		$StaticBody2D.set_collision_layer_bit(1,false)
		$StaticBody2D.set_collision_mask_bit(1,false)


func _on_Button_levier_activated():
	get_node("StaticBody2D").get_node("CollisionShape2D").disabled = true
