# VidasContainer.gd
extends HBoxContainer

func _ready():
	
	# Se você usa Godot 4 (o que parece ser o caso):
	Global.lives_updated.connect(_on_lives_updated)
	
	# Chama a função uma vez no início para mostrar os corações iniciais
	_on_lives_updated(Global.lives)


# Esta função é chamada pelo sinal do Global
func _on_lives_updated(new_lives):
	
	# Pega todos os corações (os filhos do HBoxContainer)
	var coracoes = get_children()
	
	# Loop por todos os corações
	for i in coracoes.size():
		var coracao_node = coracoes[i]
		
		# "i" é o índice (0, 1, 2...)
		# Se o índice (i) for MENOR que o número de vidas...
		if i <= new_lives:
			# ...mostra o coração.
			coracao_node.visible = true
		else:
			# ...esconde o coração.
			coracao_node.visible = false
