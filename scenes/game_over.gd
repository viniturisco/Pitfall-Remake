
extends Control

@onready var score_label = $ScoreFinalLabel

func _ready():
	# Garante que o jogo não esteja pausado caso tenhamos pausado antes
	get_tree().paused = false
	score_label.text = "SCORE: " + str(Global.score)


func _on_try_again_pressed() -> void:
	Global.reset_game()
	get_tree().change_scene_to_file("res://scenes/fase/fase.tscn")
	pass # Replace with function body.
	
func _on_quit_game_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_main_menu_pressed() -> void:
	Global.reset_game()
	get_tree().change_scene_to_file("res://scenes/tela_inicial/tela_inicial.tscn")
	pass
