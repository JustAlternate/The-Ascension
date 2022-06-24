extends Area2D

export var dialogue_npc:String
signal interacted(instance)

var lebody

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func showtext(text):
	
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
	position = get_parent().get_parent().get_node("pantin").position




