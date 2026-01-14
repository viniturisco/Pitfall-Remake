extends Marker2D

@export var cena_tronco: PackedScene 
@export var indice_minha_tela: int = 0

# --- NOVO: Tempo de espera antes de criar o tronco ---
@export var atraso_inicial: float = 0.0 
# -----------------------------------------------------

var tronco_atual = null
var tela_esta_ativa = false # Controle de segurança

func _ready():
	Global.mudou_de_tela.connect(_on_mudou_de_tela)
	checar_spawn_inicial()

func checar_spawn_inicial():
	var cam = get_viewport().get_camera_2d()
	if cam:
		var tela_inicial = int(cam.global_position.x / 1152.0)
		if tela_inicial == indice_minha_tela:
			_on_mudou_de_tela(tela_inicial) # Reusa a lógica

func _on_mudou_de_tela(novo_indice):
	if novo_indice == indice_minha_tela:
		tela_esta_ativa = true
		spawnar_tronco()
	else:
		tela_esta_ativa = false
		remover_tronco()

func spawnar_tronco():
	if tronco_atual != null:
		return
	
	# --- NOVO: Lógica do Atraso ---
	if atraso_inicial > 0:
		# Espera o tempo configurado
		await get_tree().create_timer(atraso_inicial).timeout
	
	# SEGURANÇA: Se durante a espera o jogador mudou de tela, CANCELA!
	if not tela_esta_ativa:
		return
	# ------------------------------
		
	if cena_tronco:
		tronco_atual = cena_tronco.instantiate()
		tronco_atual.position = Vector2.ZERO
		add_child(tronco_atual)

func remover_tronco():
	if tronco_atual != null:
		tronco_atual.queue_free()
		tronco_atual = null
