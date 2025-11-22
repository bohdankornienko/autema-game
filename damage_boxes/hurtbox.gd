class_name HurtBox extends Area2D

signal hurt(hitbox: Hitbox)

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(other: Area2D) -> void:
    if other is not Hitbox: return

    hurt.emit(other)
