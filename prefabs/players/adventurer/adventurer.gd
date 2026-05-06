extends CharacterBody2D
class_name Adventurer

@onready var anim : AnimatedSprite2D = $Anim
@onready var corner_check_area : Area2D = $Areas/CornerCheckArea
@onready var grab_shape : CollisionShape2D = $GrapShape

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

var direction : float = 0
@onready var face_direction : int = int(direction)
var is_attacking := false
var speed_scale := 1.0
var is_crouching := false
var is_sliding := false
var double_jump_count := 1
var gravity_scale := 1.0
var is_in_corner := false

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_move()
	handle_jump()
	handle_attack()
	handle_crouch()
	handle_slide()

	move_and_slide()

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_scale

func handle_move():
	direction = Input.get_axis("run_left", "run_right")
	if direction:
		velocity.x = direction * SPEED * speed_scale

		if not face_direction == direction:
			if not is_in_corner:
				face_direction = int(direction)

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	anim.flip_h = face_direction < 0

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_in_corner:
		velocity.y = JUMP_VELOCITY

func handle_attack():
	if not is_attacking and Input.is_action_just_pressed("attack"):
		is_attacking = true

func handle_crouch():
	is_crouching = Input.is_action_pressed("crouch")

func handle_slide():
	if not is_sliding and direction and Input.is_action_just_pressed("crouch"):
		is_sliding = true

func toogle_corner_grab(activate: bool):
	is_in_corner = activate
	grab_shape.disabled = not activate
