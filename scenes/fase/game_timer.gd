# GameTimer.gd
extends Timer

# Vamos arrastar nosso TimerLabel para esta variável no Inspetor
@export var timer_label: Label

# Esta função é chamada a CADA FRAME
func _process(_delta):
	if timer_label:
		timer_label.text = format_time(time_left)

# Esta função foi conectada ao sinal "timeout"
func _on_timeout(): # (O nome da sua função pode ser _on_GameTimer_timeout)
	# O tempo acabou! Chame a função de Game Over.
	Global.trigger_game_over()


# Função extra para formatar o tempo em MM:SS
func format_time(seconds: float) -> String:
	# Converte o total de segundos para minutos
	var minutes = int(seconds / 60)
	
	# Pega o resto dos segundos
	var remaining_seconds = int(seconds) % 60
	
	# Formata o texto (ex: "02:05")
	# (Esta é a sintaxe de formatação do Godot 3 / GDScript 1)
	return "%02d:%02d" % [minutes, remaining_seconds]
