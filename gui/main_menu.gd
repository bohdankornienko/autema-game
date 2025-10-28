extends CanvasLayer


signal start_requested

func _on_button_start_button_up() -> void:
    start_requested.emit()
