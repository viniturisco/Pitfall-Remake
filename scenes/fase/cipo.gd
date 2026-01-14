# Cipo.gd
extends Node2D # Note que é Node2D, pois é o pivô

@onready var ponto_segurar: Marker2D = $PontoSegurar
@onready var sfx_scream: AudioStreamPlayer = $SomCipo/SFX_scream
var pode_agarrar = true 


func _ready():
	$AnimationPlayer.play("balancar")
	
func anexar_harry(body):
	
	body.reparent(self)
	body.position = ponto_segurar.position
	body.rotation = 0 
	#var musica = get_tree().current_scene.get_node_or_null("Sons/GameMusic")
	#if musica:
	#	musica.stream_paused = true
	sfx_scream.play()
	#await sfx_scream.finished
	#musica.stream_paused = false
	
func iniciar_cooldown():
	pode_agarrar = false
	await get_tree().create_timer(1.0).timeout	
	pode_agarrar = true

func _on_area_pegar_body_entered(body):
	if body.name == "Harry" and pode_agarrar:
		if body.esta_no_cipo:
			return
		body.esta_no_cipo = true
		call_deferred("anexar_harry", body)
