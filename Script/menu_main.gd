extends Node

var music_bus_idx = AudioServer.get_bus_index("music")
var lowpassfilter = AudioServer.get_bus_effect(music_bus_idx,0)

func _ready():
	lowpassfilter.cutoff_hz = 20000
	AudioServer.set_bus_effect_enabled(music_bus_idx,1,false)
	if GlobalVariables.current_level == 0:
		$Button6.disabled = true
	else:
		$Button6.disabled = false
	var save_game = File.new()
	if save_game.file_exists("user://savegame.save"):
		$Button5.disabled = false
	else:
		$Button5.disabled = true

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

func save_game():					# Créé un fichier de sauvegarde ou l'écrase s'il existe déjà
	var save_game = File.new()
	save_game.open("user://savegame.save",File.WRITE)
	
	var save_data = GlobalVariables.call("save")
	save_game.store_line(to_json(save_data))
	save_game.close()


func _on_Button6_button_up():
	save_game()


func _on_Button5_button_up():
	var level = GlobalVariables.current_level
	if level == 1:
		var map_name = "niveau_1"
		var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
		get_tree().change_scene(path)
	elif level == 2:
		var map_name = "niveau_2"
		var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
		get_tree().change_scene(path)
	elif level == 3:
		var map_name = "niveau_3"
		var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
		get_tree().change_scene(path)
	elif level == 4:
		var map_name = "niveau_4"
		var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
		get_tree().change_scene(path)
	elif level == 5:
		var map_name = "niveau_5"
		var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
		get_tree().change_scene(path)
	elif level == 6:
		var map_name = "niveau_6"
		var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
		get_tree().change_scene(path)
	else:
		var map_name = "niveau_intro"
		var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
		get_tree().change_scene(path)
