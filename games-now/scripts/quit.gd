extends TextureButton

@export var audio_stream_player: AudioStreamPlayer

func _on_pressed() -> void:
	audio_stream_player.play()
	get_tree().quit()
