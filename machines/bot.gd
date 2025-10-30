extends CharacterBody2D

@export var move_speed = 9000

func process_input(delta: float):
    var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = input_direction * move_speed * delta
    look_at(get_global_mouse_position())

func _physics_process(delta: float) -> void:
    process_input(delta)
    move_and_slide()
