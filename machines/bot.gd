class_name PlayerBot extends CharacterBody2D

const METER = 64

## meters per second (where meter is 64 pixels)
@export var move_speed = 1.0

## The number of times the melee attack can be performed per second.
@export var attack_speed = 1.0

## meters per second (where meter is 64 pixels)
@export var dash_speed = 5.0

@onready var melee_collision = $MeleeShapeCast2D
@onready var melee_atck_indicator = $MeleeAttackIndicator
@onready var melee_timer = $MeleeTimer

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

var can_attack: bool = true
var input_direction = Vector2.ZERO

func _ready() -> void:
    melee_timer.wait_time = 1.0 / attack_speed
    move_speed = move_speed * METER
    dash_speed = dash_speed * METER

func process_input(_delta: float):
    var state = playback.get_current_node()

    input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    look_at(get_global_mouse_position())

    if state == "MoveState":
        velocity = input_direction * move_speed
    elif state == "DashState":
        velocity = input_direction * dash_speed

    if Input.is_action_just_pressed("mouse_left") and can_attack:
        playback.travel("AttackState")
        can_attack = false
        melee_timer.start()
        melee_atck_indicator.show()

        if melee_collision.is_colliding():
            for i in range(melee_collision.get_collision_count()):
                var target = melee_collision.get_collider(i)
                if target and target.is_in_group("Destructible"):
                    target.take_damage(50)
    if Input.is_action_just_pressed("dash"):
        playback.travel("DashState")

func _physics_process(delta: float) -> void:
    process_input(delta)
    move_and_slide()


func _on_melee_timer_timeout() -> void:
    can_attack = true
    melee_atck_indicator.hide()
