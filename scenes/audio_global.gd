extends Node


@onready var sfx_botao: AudioStreamPlayer = $SFX_botao
@onready var musica_menu = $MusicaMenu

func play_click():
	sfx_botao.play()

func tocar_musica_menu():
	if not musica_menu.playing:
		musica_menu.play()

func parar_musica_menu():
	musica_menu.stop()
