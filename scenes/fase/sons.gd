extends Node

@onready var sfx_dano = $SFX_Dano
@onready var sfx_tesouros = $SFX_Tesouros
@onready var sfx_perdeu_pontos = $SFX_perdeu_pontos
@onready var sfx_game_over = $SFX_game_over
@onready var sfx_victory: AudioStreamPlayer = $SFX_Victory

func _ready():
	Global.sfx_perdeu_vida.connect(_tocar_som_dano)
	Global.sfx_perdeu_pontos.connect(_som_perdeu_pontos)
	Global.sfx_ganhou_pontos.connect(_som_ganhou_pontos)
	Global.sfx_game_over.connect(_tocar_som_game_over)
	Global.sfx_victory.connect(_tocar_som_victory)
	
	
func _tocar_som_game_over():
	sfx_game_over.play()
	
func _tocar_som_victory():
	sfx_victory.play()

func _tocar_som_dano():
	sfx_dano.play()

func _som_ganhou_pontos():
	if not sfx_tesouros.playing:
		sfx_tesouros.play()

func _som_perdeu_pontos():
	if not sfx_perdeu_pontos.playing:
		sfx_perdeu_pontos.play()
		
		
