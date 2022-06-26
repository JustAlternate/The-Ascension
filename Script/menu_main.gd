extends Node

var music_bus_idx = AudioServer.get_bus_index("music")
var lowpassfilter = AudioServer.get_bus_effect(music_bus_idx,0)

func _ready():
	lowpassfilter.cutoff_hz = 20000
	AudioServer.set_bus_effect_enabled(music_bus_idx,1,false)

func _process(_delta):
	if $Sprite.position.y > -1320:
		$Sprite.position.y -= 1
		
func _on_Button_button_up():
	var map_name = "niveau_intro"
	var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
	get_tree().change_scene(path)
	
func _on_Button3_button_up():
	get_tree().quit()


func _on_Button2_button_up():
	var scene_name = "options"
	var path = "res://Scenes/UI/{scene_name}.tscn".format({"scene_name":scene_name})
	get_tree().change_scene(path)


func _on_Button4_button_up():
	var scene_name = "credits"
	var path = "res://Scenes/UI/{scene_name}.tscn".format({"scene_name":scene_name})
	get_tree().change_scene(path)
