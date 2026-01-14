extends Node2D

var score = 1000
signal score_updated(new_score)
signal mudou_de_tela(indice_nova_tela)
var lives = 3
signal lives_updated(new_lives) 
var current_respawn_point: Vector2

signal sfx_perdeu_vida
signal sfx_perdeu_pontos
signal sfx_ganhou_pontos
signal sfx_game_over
signal sfx_victory

func notificar_mudanca_tela(novo_indice):
	mudou_de_tela.emit(novo_indice)

func trigger_game_over():
	get_tree().paused = true
	sfx_game_over.emit()
	await get_tree().create_timer(3.0).timeout
	# 4. (Opcional) Despausa antes de mudar de cena
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over/game_over.tscn")
	
func trigger_victory():
	get_tree().paused = true
	sfx_victory.emit()
	await get_tree().create_timer(4.0).timeout
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over/you_win.tscn")

func lose_life():
	lives -= 1
	lives_updated.emit(lives)
	if lives > 0:
		sfx_perdeu_vida.emit()
	if lives <= 0:
		trigger_game_over()


func set_respawn_point(new_position: Vector2):
	current_respawn_point = new_position

func add_points(points):
	score += points
	score_updated.emit(score) 
	sfx_ganhou_pontos.emit()
	if score >= 9700:
		trigger_victory()

func lose_points(points):
	score -= points
	if score < 0:
		score = 0
	score_updated.emit(score) 
	sfx_perdeu_pontos.emit()

func reset_game():
	score = 1000
	lives = 3
	score_updated.emit(score)
	lives_updated.emit(lives)
