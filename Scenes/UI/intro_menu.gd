extends Node


	
var music_bus_idx = AudioServer.get_bus_index("music")
var lowpassfilter = AudioServer.get_bus_effect(music_bus_idx,0)

func _ready():
	randomize()
	lowpassfilter.cutoff_hz = 20000
	AudioServer.set_bus_effect_enabled(music_bus_idx,1,false)
	yield(get_tree().create_timer(11), "timeout")
	var next_scene = preload("res://Scenes/UI/menu_main.tscn")
	get_tree().change_scene_to(next_scene)
	load_game()
	
func load_game():
	var save_game = File.new()
	if save_game.file_exists("user://savegame.save"):
		save_game.open("user://savegame.save", File.READ)
		var save_data = parse_json(save_game.get_line())
		
		GlobalVariables.master_volume = save_data["master_volume"]
		GlobalVariables.music_volume = save_data["music_volume"]
		GlobalVariables.sfx_volume = save_data["sfx_volume"]
		GlobalVariables.current_level = save_data["current_level"]
