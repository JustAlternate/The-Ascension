extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$music/musicVolume.set_value(GlobalVariables.music_volume)
	$sfx/sfxVolume.set_value(GlobalVariables.sfx_volume)
	$master/masterVolume.set_value(GlobalVariables.master_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), log(GlobalVariables.music_volume) * 20)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), log(GlobalVariables.sfx_volume) * 20)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), log(GlobalVariables.master_volume) * 20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_button_up():
	var scene_name = "menu_main"
	var path = "res://Scenes/UI/{scene_name}.tscn".format({"scene_name":scene_name})
	get_tree().change_scene(path)


func _on_musicVolume_value_changed(value):
	GlobalVariables.music_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), log(GlobalVariables.music_volume) * 20)


func _on_sfxVolume_value_changed(value):
	GlobalVariables.sfx_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), log(GlobalVariables.sfx_volume) * 20)


func _on_masterVolume_value_changed(value):
	GlobalVariables.master_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), log(GlobalVariables.master_volume) * 20)
