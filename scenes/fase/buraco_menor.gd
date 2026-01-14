# Buraco.gd
extends Area2D
# Exporte estas variáveis para poder ajustá-las no Inspetor
@export var pontos_perdidos = 100


func _on_body_entered(body):
	# Verifica se foi o Player que entrou
	if body.name == "Harry":
		
		# 1. Chama o Singleton e remove os pontos
		Global.lose_points(pontos_perdidos)
		if body.has_method("tomar_dano_visual"):
			body.tomar_dano_visual()
