extends Area2D

func _on_body_entered(body):
	if body.name == "Harry":
		# APENAS avisa que está perto. Não muda o estado ainda.
		body.perto_da_escada = true

func _on_body_exited(body):
	if body.name == "Harry":
		body.perto_da_escada = false
	
func _on_barreira_escada_body_entered(body: Node2D) -> void:
	if body.name == "Harry":
		body.esta_na_barreira_escada = true
	pass # Replace with function body.
	
func _on_barreira_escada_body_exited(body: Node2D) -> void:
	if body.name == "Harry":
		body.esta_na_barreira_escada = false
	pass # Replace with function body.
