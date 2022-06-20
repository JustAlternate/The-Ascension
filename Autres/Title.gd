extends Node

onready var label_style := preload("res://Scenes/menu_title_font.tres")
var size = 32
var direction = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label_style.size = size
	if direction:
		size+=0.5
	else:
		size-=0.5
	if size > 100:
		direction = false
	if size < 50 :
		direction = true
	
