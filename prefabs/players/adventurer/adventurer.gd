extends CharacterBody2D
class_name Adventurer

@onready var anim : AnimatedSprite2D = $Anim

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

var direction : float = 0
@onready var face_direction := direction

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_move()
	handle_jump()

	move_and_slide()

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_move():
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED

		if not face_direction == direction:
			face_direction = direction

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	anim.flip_h = face_direction < 0

func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
