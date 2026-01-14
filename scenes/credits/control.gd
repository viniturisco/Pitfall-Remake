extends Control
@onready var quit_game: Button = $VBoxContainer/quit_game
@onready var go_back: Button = $"VBoxContainer/go_back"

func _ready():
	AudioGlobal.tocar_musica_menu()

func _on_go_back_pressed() -> void:
	AudioGlobal.play_click()
	get_tree().change_scene_to_file("res://scenes/tela_inicial/tela_inicial.tscn")
	pass # Replace with function body.


func _on_quit_game_pressed() -> void:
	AudioGlobal.play_click()
	get_tree().quit()
	pass # Replace with function body.
