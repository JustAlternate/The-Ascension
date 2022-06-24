extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func change_color():
	if material == load("res://shader_inversion.tres"):
		material = null
	else:
		material = load("res://shader_inversion.tres")
