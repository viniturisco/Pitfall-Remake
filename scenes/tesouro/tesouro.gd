# Tesouro.gd (Versão para AnimatedSprite2D)
extends Area2D

@export var pontos = 500
# Agora exportamos um TEXTO (o nome da animação)
@export var nome_da_animacao: String = "default"

@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	# Define a animação para tocar
	anim_sprite.animation = nome_da_animacao
	anim_sprite.play() # Toca a animação

func _on_body_entered(body):
	if body.name == "Harry":
		Global.add_points(pontos)
		queue_free()
