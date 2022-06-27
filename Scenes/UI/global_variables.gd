extends Node


var master_volume = 1
var music_volume = 1
var sfx_volume = 1

var current_level = 0 # Niveau intro

func save():
	var save_dict = {
		"master_volume" : master_volume,
		"music_volume" : music_volume,
		"sfx_volume" : sfx_volume,
		"current_level" : current_level
	}
	return save_dict
