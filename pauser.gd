extends Node

@onready var unpause_audio_stream_player: AudioStreamPlayer = $UnpauseAudioStreamPlayer
@onready var pause_audio_stream_player: AudioStreamPlayer = $PauseAudioStreamPlayer

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("cancel"):
        var is_paused = get_tree().paused

        if is_paused: unpause_audio_stream_player.play()
        else: pause_audio_stream_player.play()

        get_tree().paused = not is_paused
