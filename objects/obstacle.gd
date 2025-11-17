#class_name Obstacle extends StaticBody2D
extends StaticBody2D

@export var max_health : float = 100.0
@export var health : float = 100.0

signal destroyed(pos: Vector2)

func _ready() -> void:
    health = min(health, max_health)

func take_damage(value: float):
    health -= value

    if health <= 0.0:
        queue_free()
        destroyed.emit(global_position)
        print("emit event")
