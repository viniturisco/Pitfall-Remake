extends Area2D

@export var velocidade = 250.0
@export var pontos_perdidos = 100
# Distância que ele anda antes de resetar (largura da tela)
@export var distancia_percorrida = 1152.0 
@export var tempo_de_respawn = 2.0

@onready var colisao_tronco = $ColisaoTronco

# Posição onde ele nasceu (definida pelo Spawner)
var start_x
var limite_esquerdo
var esta_esperando = false

func _ready():
	# Salva onde nasceu para poder voltar pra cá depois
	start_x = position.x
	limite_esquerdo = start_x - distancia_percorrida
	
	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.play("default")
	elif has_node("AnimacaoTronco"):
		$AnimacaoTronco.play("default")

func _process(delta):
	if esta_esperando:
		return

	# Move
	position.x -= velocidade * delta

	# Se chegou no fim do trajeto
	if position.x < limite_esquerdo:
		iniciar_respawn()

func iniciar_respawn():
	esta_esperando = true
	
	# Volta para o início
	position.x = start_x
	
	# Fica invisível e intangível
	visible = false
	if colisao_tronco: colisao_tronco.set_deferred("disabled", true)

	# Espera
	await get_tree().create_timer(tempo_de_respawn).timeout

	# Reaparece
	visible = true
	if colisao_tronco: colisao_tronco.set_deferred("disabled", false)
	
	esta_esperando = false

func _on_body_entered(body):
	if body.name == "Harry":
		Global.lose_points(pontos_perdidos)
		if body.has_method("tomar_dano_visual"):
			body.tomar_dano_visual()
