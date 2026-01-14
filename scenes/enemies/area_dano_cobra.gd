# Hurtbox.gd
extends Area2D

func _on_body_entered(body):
	if body.name == "Harry":
		Global.lose_life()
		body.global_position = Global.current_respawn_point
		body.pode_mover = true
		body.esta_na_escada = false      # Tira do modo escada
		body.perto_da_escada = false     # Reseta proximidade
		body.esta_na_barreira_escada = false
