extends Node2D

@onready var overlay_main_menu = $MainMenu
@onready var overlay_you_won = $YouWon
@onready var overlay_you_loose: CanvasLayer = $YouLoose
@onready var overlay_hud: CanvasLayer = $HUD
@onready var bot: PlayerBot = $Bot

func _ready() -> void:
    bot.died.connect(_on_player_died)

func _on_area_2d_body_entered(_body: Node2D) -> void:
    print("The core")
    overlay_you_won.show()
    get_tree().paused = true


func _on_player_died() -> void:
    overlay_hud.hide()
    overlay_you_loose.show()
