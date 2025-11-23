extends CanvasLayer

@export var stats: Stats

@onready var health_bar: ProgressBar = $P/MC/Rows/RowTop/HealthBar

func _ready() -> void:
    health_bar.min_value = 0.0
    health_bar.max_value = stats.max_health
    health_bar.value = stats.health

    stats.health_changed.connect(update_health_status)

func update_health_status() -> void:
    health_bar.value = stats.health
