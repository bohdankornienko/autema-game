extends Node2D

@onready var overlay_main_menu = $MainMenu
@onready var overlay_you_won = $YouWon


func _on_area_2d_body_entered(_body: Node2D) -> void:
    overlay_you_won.show()
    get_tree().paused = true
