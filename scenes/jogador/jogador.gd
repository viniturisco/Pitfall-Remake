extends CharacterBody2D

var pode_mover = true # Variável de controle da câmera
@onready var sfx_jump: AudioStreamPlayer = $SFX_jump

const SPEED = 230.0
const JUMP_VELOCITY = -300.0
var esta_na_escada = false
var perto_da_escada = false
var esta_na_barreira_escada = false
var velocidade_escada = 100.0
var esta_no_cipo = false

@onready var animacao_jogador: AnimatedSprite2D = $AnimacaoJogador

func soltar_cipo():
	if get_parent().has_method("iniciar_cooldown"):
		get_parent().iniciar_cooldown()
	esta_no_cipo = false
	call_deferred("sair_do_cipo_deferred")
	
func sair_do_cipo_deferred():
	reparent(get_tree().current_scene)
	velocity.y = JUMP_VELOCITY
	rotation = 0
	# pode_mover = true

func _physics_process(delta: float) -> void:
	if not pode_mover:
		return
		
	if esta_no_cipo:
		animacao_jogador.play("hanging")
		velocity = Vector2.ZERO
		# pode_mover = false
			
		# (Opcional) Pular para baixo
		if Input.is_action_just_pressed("ui_down"):
			soltar_cipo()
			return
		return

	# --- LÓGICA DA ESCADA (JÁ ESTÁ SUBINDO) ---
	if esta_na_escada:
		# 1. Pular para sair (seu código anterior)
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			esta_na_escada = false
			return
			
		else:
			velocity.y = 0
			var direcao_y = Input.get_axis("ui_up", "ui_down")
			
			if esta_na_barreira_escada and direcao_y < 0:
				direcao_y = 0
			
			if direcao_y != 0:
				velocity.y = direcao_y * velocidade_escada
				animacao_jogador.play("subindo")
			else:
				animacao_jogador.play("subindo")
				animacao_jogador.stop()
			
			# Movimento Horizontal na escada
			# var direcao_x = Input.get_axis("ui_left", "ui_right")
			velocity.x = 0 #direcao_x * SPEED

	# --- LÓGICA NORMAL (CHÃO) ---
	else:		
		# 2. NOVA LÓGICA: AGARRAR A ESCADA
		if perto_da_escada and Input.get_axis("ui_up", "ui_down") != 0:
			esta_na_escada = true
			velocity.x = 0 
			# IMPORTANTE: Adicione este return para impedir que a gravidade atue neste frame
			return
		
		# ... (Resto da sua lógica de gravidade e andar) ...
		if not is_on_floor():
			velocity += get_gravity() * delta
			animacao_jogador.play("jump")

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			sfx_jump.play()
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if is_on_floor():
			if direction > 0:
				animacao_jogador.flip_h = 	false
				animacao_jogador.play("andando")
			elif direction < 0:
				animacao_jogador.flip_h = true
				animacao_jogador.play("andando")
			else: 
				animacao_jogador.play("parado")
				
	

	move_and_slide()
func tomar_dano_visual():
	var tween = get_tree().create_tween()

	tween.tween_property(animacao_jogador, "modulate", Color(1, 0, 0), 0.1) # 0.1s para ficar vermelho

	tween.tween_property(animacao_jogador, "modulate", Color(1, 1, 1), 0.1) # 0.1s para voltar
