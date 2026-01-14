# ScoreLabel.gd (Corrigido para Godot 4)
extends Label

func _ready():
	# 1. Conecta ao sinal usando a sintaxe do Godot 4
	Global.score_updated.connect(_on_score_updated) # MUDANÇA AQUI
	
	# 2. Define o texto inicial
	text = "SCORE: " + str(Global.score)

# Esta função é chamada pelo sinal
func _on_score_updated(new_score):
	text = "SCORE: " + str(new_score)
