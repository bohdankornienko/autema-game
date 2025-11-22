extends CharacterBody2D

@export var detection_range = 200
@export var stats: Stats

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var hurt_box: HurtBox = $HurtBox

const SPEED = 60
const FRICTION = 500

func _ready() -> void:
    stats = stats.duplicate()
    hurt_box.area_entered.connect(take_hit.call_deferred)
    stats.no_health.connect(queue_free)

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
        "hit":
            velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
            move_and_slide()

func take_hit(other: Hitbox) -> void:
    stats.health -= other.damage
    velocity = other.knockback_direction * other.knockback_amount
    playback.start("hit")


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
