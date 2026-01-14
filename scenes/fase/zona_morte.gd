extends Area2D

func _on_body_entered(body):
	if body.name == "Harry":
		Global.lose_life()
		body.global_position = Global.current_respawn_point
		body.velocity = Vector2.ZERO
		body.pode_mover = true
		body.esta_na_escada = false
		body.perto_da_escada = false
		body.esta_na_barreira_escada = false
		body.esta_no_cipo = false 
		body.rotation = 0
