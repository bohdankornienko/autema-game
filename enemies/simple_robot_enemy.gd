extends CharacterBody2D

@export var detection_range = 200

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback
@onready var ray_cast_2d: RayCast2D = $RayCast2D

const SPEED = 60

func _physics_process(delta: float) -> void:
    var state = playback.get_current_node()

    match state:
        "idle": pass
        "chase":
            var player: = get_player()
            if player is PlayerBot:
                velocity = global_position.direction_to(player.global_position) * SPEED
                look_at(player.global_position)
            else:
                velocity = Vector2.ZERO
            move_and_slide()


func get_player() -> PlayerBot:
    return get_tree().get_first_node_in_group("player")

func is_player_in_detection_range() -> bool:
    var result = false

    var player: = get_player()
    if player is PlayerBot:
        var distance_to_player = global_position.distance_to(player.global_position)
        if distance_to_player < detection_range:
            result = true

    return result

func can_see_player() -> bool:
    if not is_player_in_detection_range(): return false

    var player: = get_player()
    if player is not PlayerBot: return false

    ray_cast_2d.target_position = to_local(player.global_position) # - global_position # TODO: does not work
    ray_cast_2d.force_raycast_update()
    var player_in_sight: = not ray_cast_2d.is_colliding()

    return player_in_sight
