class_name Stats extends Resource

signal no_health
signal health_changed

@export var health: = 100 :
    set(value):
        var previous_health = health
        health = value
        if health != previous_health: health_changed.emit()
        if health <= 0: no_health.emit()

@export var max_health: = 100
