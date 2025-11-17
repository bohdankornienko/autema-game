extends Node2D

@export var DESTTROYED_EFFECT : PackedScene

func _ready() -> void:
    var items = get_children()
    print("number of obsticles: ", len(items))

    for item in items:
        item.destroyed.connect(spawn_destroyed_effect)


func spawn_destroyed_effect(pos: Vector2) -> void:
    var effect = DESTTROYED_EFFECT.instantiate()
    effect.position = pos
    add_child(effect)
    effect.show()
    effect.emitting = true
    print("show effect")
