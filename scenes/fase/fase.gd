extends Node2D

@onready var harry: CharacterBody2D = $Harry
@onready var camera_2d: Camera2D = $Camera2D

@export var camera: Camera2D
@export var respawn: Marker2D

# Configurações do Mapa
var teleporte_offset = 128.0 # Distância que o player entra na nova tela
var largura_da_tela = 1152.0
var ultimo_x_camera = 20736.0 # Posição X da câmera na última tela

func _ready() -> void:
	if respawn:
		Global.set_respawn_point(respawn.global_position)

	var indice_inicial = int(respawn.global_position.x / largura_da_tela)
	Global.notificar_mudanca_tela(indice_inicial)
# --- INDO PARA A DIREITA (->) ---
func _on_trigger_tela_direita_body_entered(body):
	if body.name == "Harry" and body.pode_mover:
		body.pode_mover = false

		var pos_atual_camera = camera.global_position
		
		# Calcula a posição "alvo" normal (uma tela para a direita)
		var nova_cam = Vector2(pos_atual_camera.x + largura_da_tela, pos_atual_camera.y)
		# Calcula a posição alvo do player (um pouco a frente de onde ele está)
		var novo_player = Vector2(body.global_position.x + teleporte_offset, body.global_position.y)
		
		# CASO 1: Estamos na ÚLTIMA tela indo para a "fantasma"
		if pos_atual_camera.x >= ultimo_x_camera:
			# Chamamos o movimento suave, mas avisamos que é um WRAP (true no final)
			# Ele vai animar até o "além" e depois cortar para zero.
			mover_suavemente(body, nova_cam, novo_player, true, false)
			
		# CASO 2: Movimento Normal
		else:
			# Movimento normal, sem wrap (false, false)
			mover_suavemente(body, nova_cam, novo_player, false, false)


# --- INDO PARA A ESQUERDA (<-) ---
func _on_trigger_tela_esquerda_body_entered(body: Node2D) -> void:
	if body.name == "Harry" and body.pode_mover:
		body.pode_mover = false

		var pos_atual_camera = camera.global_position

		# Calcula a posição "alvo" normal (uma tela para a esquerda)
		var nova_cam = Vector2(pos_atual_camera.x - largura_da_tela, pos_atual_camera.y)
		# Calcula a posição alvo do player (um pouco para trás)
		var novo_player = Vector2(body.global_position.x - teleporte_offset, body.global_position.y)

		# CASO 1: Estamos na PRIMEIRA tela indo para a esquerda (Wrap negativo)
		if pos_atual_camera.x <= 0:
			# Animamos para uma tela fantasma negativa e avisamos para resetar pro fim (true no segundo parametro)
			mover_suavemente(body, nova_cam, novo_player, false, true)
			
		# CASO 2: Movimento Normal
		else:
			mover_suavemente(body, nova_cam, novo_player, false, false)

# --- FUNÇÃO AUXILIAR MÁGICA ---

# Agora aceita dois parâmetros extras opcionais para saber se deve resetar a posição
func mover_suavemente(body, pos_cam_destino, pos_player_destino, resetar_para_inicio=false, resetar_para_fim=false):
	
	# 1. Faz o TWEEN (A ilusão de ótica)
	# Ele move a câmera e o player suavemente, mesmo se for para uma área "fora" do mapa
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(camera, "global_position", pos_cam_destino, 0.3)
	tween.tween_property(body, "global_position", pos_player_destino, 0.3)
	
	await tween.finished
	
	# 2. O CORTE SECO (A mágica acontece aqui)
	# Assim que a animação termina, se for um wrap, nós teleportamos instantaneamente.
	
	if resetar_para_inicio:
		# Se foi da última para a primeira:
		camera.global_position = Vector2(0, camera.global_position.y)
		# Coloca o Harry no início da primeira tela
		body.global_position = Vector2(teleporte_offset, body.global_position.y)
		
	elif resetar_para_fim:
		# Se foi da primeira para a última:
		camera.global_position = Vector2(ultimo_x_camera, camera.global_position.y)
		# Coloca o Harry no fim da última tela
		body.global_position = Vector2(ultimo_x_camera + largura_da_tela - teleporte_offset, body.global_position.y)

	# 3. Finalização normal
	# Atualiza o respawn baseado na posição REAL onde a câmera parou agora
	atualizar_respawn(camera.global_position)
	body.pode_mover = true
	
	var novo_indice_tela = int(camera.global_position.x / largura_da_tela)
	Global.notificar_mudanca_tela(novo_indice_tela)


func atualizar_respawn(posicao_camera_atual):
	# O respawn é sempre um pouco a frente de onde a câmera está agora
	var novo_respawn = Vector2(posicao_camera_atual.x + 100, respawn.global_position.y)
	respawn.global_position = novo_respawn
	Global.set_respawn_point(novo_respawn)
