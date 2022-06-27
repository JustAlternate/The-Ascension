extends Area2D

export(Array,String, MULTILINE) var dialogue_npc
export(String, MULTILINE) var default_dialogue
signal interacted(instance)
export var skin = 0
var randompitch = 1.0
export var font_size = 70
export var flip_horizontal = false
export var flip_vertical = false
export var speed_between_letters = 0.1
export var delay_before_speaking = 0
export var delay_after_speaking = 5
export var autospeak = false
var speaking = false

var player_in_range = false
# Called when the node enters the scene tree for the first time.
func _ready():

	$AnimatedSprite.flip_h = flip_horizontal
	$AnimatedSprite.flip_v = flip_vertical
	
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Scenes/UI/test.ttf")
	dynamic_font.size = font_size
	$"Label".set("custom_fonts/font", dynamic_font)
	match skin:
		0:
			$AnimatedSprite.animation = "default"
		1:
			$AnimatedSprite.animation = "PNJ1"
		2:
			$AnimatedSprite.animation = "PNJ2"
		3:
			$AnimatedSprite.animation = "PNJ3"
		4:
			$AnimatedSprite.animation = "RobotCalin"
		5:
			$AnimatedSprite.animation = "RobotInterrogation"
		6:
			$AnimatedSprite.animation = "RobotNeutre"
		7:
			$AnimatedSprite.animation = "RobotVener"
	if autospeak:
		show_text(dialogue_npc.pop_front())


func show_text(text):
	speaking = true
	yield(get_tree().create_timer(delay_before_speaking),"timeout")
	
	if $Sprite.visible == false:
		
		$Label.show()
		$Sprite.show()
		
		for i in text:
			randompitch = rand_range(0.8,1.2)
			yield(get_tree().create_timer(speed_between_letters),"timeout")
			$Label.text = $Label.text + i
			$AudioStreamPlayer.play()
		
		emit_signal("interacted",self)

		yield(get_tree().create_timer(2),"timeout")
		$Label.text = ""
		$Sprite.visible = false
		$Label.visible = false
		speaking = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_in_range:
		if Input.is_action_just_pressed("interact") and not speaking:
			if dialogue_npc.empty():
				show_text(default_dialogue)
			else:
				show_text(dialogue_npc.pop_front())


func _on_Bonhomme_body_entered(body):
	if body.is_in_group("playable"):
		player_in_range = true


func _on_Bonhomme_body_exited(body):
	if body.is_in_group("playable"):
		player_in_range = false

