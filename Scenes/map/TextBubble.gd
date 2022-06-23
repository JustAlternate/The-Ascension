extends Area2D

export var dialogue_npc:String
var player_in_range = false
signal interacted(instance)

var lebody

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func show_text(text):
	
	if $Sprite.visible == false:
		
		$Label.show()
		$Sprite.show()
		
		for i in text:
			yield(get_tree().create_timer(.03),"timeout")
			$Label.text = $Label.text + i
		
		emit_signal("interacted",self)

		yield(get_tree().create_timer(5),"timeout")
		$Label.text = ""
		$Sprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_range:
		if Input.is_action_just_pressed("interact"):
			show_text(dialogue_npc)
	position = get_parent().get_parent().get_node("body").position





func _on_TextBubble_body_exited(body):
	if body.is_in_group("playable"):
		player_in_range = false


func _on_TextBubble_body_entered(body):
	if body.is_in_group("playable"):
		player_in_range = true
		lebody = body
