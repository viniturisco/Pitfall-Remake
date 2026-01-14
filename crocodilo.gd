extends StaticBody2D

# Configurações de Tempo
@export var tempo_fechado = 3.0
@export var tempo_aberto = 3.0

# Referências
@onready var anim = $AnimatedSprite2D
@onready var colisao_boca = $ColisaoBoca

func _ready():
	# Inicia o ciclo eterno
	ciclo_vida()

func ciclo_vida():
	# --- ESTADO 1: BOCA FECHADA (Seguro) ---
	anim.play("fechado")
	
	# Ativa a colisão da boca (Harry pode pisar)
	colisao_boca.set_deferred("disabled", false)
	
	# Espera o tempo configurado
	await get_tree().create_timer(tempo_fechado).timeout
	
	anim.play("aberto")
	
	# Desativa a colisão da boca (Harry cai se estiver aqui)
	colisao_boca.set_deferred("disabled", true)
	
	# Espera o tempo configurado
	await get_tree().create_timer(tempo_aberto).timeout
	
	# --- REINICIA O CICLO ---
	ciclo_vida()
