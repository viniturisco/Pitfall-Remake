# Scorpiao.gd
extends CharacterBody2D

# --- Variáveis de Movimento ---
@export var speed = 40.0
@export var move_distance = 400.0 # Distância (em pixels) que ele vai andar

var direction = 1.0 # 1 = direita, -1 = esquerda
var initial_position: Vector2
var target_position_x: float

# Referência para o sprite, para podermos virá-lo
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	# Guarda a posição inicial
	initial_position = global_position
	# Define o primeiro alvo (à direita)
	target_position_x = initial_position.x + move_distance
	
	# Inicia a animação
	animated_sprite.play("default")

func _physics_process(delta):
	# Define a velocidade
	velocity.x = direction * speed
	velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	
	move_and_slide()
	
	# --- Lógica para Virar ---
	# Se indo para a direita E passou do alvo
	if direction == 1.0 and global_position.x >= target_position_x:
		direction = -1.0 # Vira para a esquerda
		target_position_x = initial_position.x # Alvo é a posição inicial
		animated_sprite.flip_h = true # Vira o sprite
		
	# Se indo para a esquerda E passou do alvo
	elif direction == -1.0 and global_position.x <= target_position_x:
		direction = 1.0 # Vira para a direita
		target_position_x = initial_position.x + move_distance # Alvo é a distância
		animated_sprite.flip_h = false # Desvira o sprite
