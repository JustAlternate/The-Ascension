extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_button_up():
	var scene_name = "menu_main"
	var path = "res://Scenes/UI/{scene_name}.tscn".format({"scene_name":scene_name})
	get_tree().change_scene(path)



func _on_musicVolume_value_changed(value):
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), log(value)*20)


func _on_sfxVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), log(value)*20)



func _on_masterVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), log(value)*20)
