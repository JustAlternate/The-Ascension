extends Node

var map_list = ["MAP1", "MAP2"]
var index_list = 0

func _on_Button_button_up():
	var map_name = map_list[index_list]
	var path = "res://Scenes/{map_name}.tscn".format({"map_name":map_name})
	get_tree().change_scene(path)


func _on_Button2_button_up():
		get_tree().quit()


func _on_Button3_button_up():
	index_list += 1
	index_list = index_list%len(map_list)
	$Button3.text = map_list[index_list]
	$Button3.update()
