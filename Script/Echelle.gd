extends Area2D

signal montage_echelle
signal pas_echelle

func _on_Echelle_body_entered(body):
	if body.name == "body":
		emit_signal("montage_echelle")


func _on_Echelle_body_exited(body):
		if body.name == "body":
			emit_signal("pas_echelle")
