#class_name Obstacle extends StaticBody2D
extends StaticBody2D

@export var max_health : float = 100.0
@export var health : float = 100.0
@onready var hurt_box: HurtBox = $HurtBox
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal destroyed(pos: Vector2)

func _ready() -> void:
    health = min(health, max_health)
    hurt_box.hurt.connect(_on_hurt)

func _on_hurt(hitbox: Hitbox) -> void:
    take_damage(hitbox.damage)
    animation_player.play("shake")

func take_damage(value: float):
    health -= value

    if health <= 0.0:
        queue_free()
        destroyed.emit(global_position)
        print("emit event")
