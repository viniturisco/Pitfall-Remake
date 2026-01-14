extends Control

func _ready():
	AudioGlobal.tocar_musica_menu()

func _on_start_pressed() -> void:
	AudioGlobal.play_click()
	AudioGlobal.parar_musica_menu()
	get_tree().change_scene_to_file("res://scenes/fase/fase.tscn")
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	AudioGlobal.play_click()
	get_tree().change_scene_to_file("res://scenes/credits/control.tscn")
	pass # Replace with function body.


func _on_quit_game_pressed() -> void:
	AudioGlobal.play_click()
	get_tree().quit()
	pass # Replace with function body.
