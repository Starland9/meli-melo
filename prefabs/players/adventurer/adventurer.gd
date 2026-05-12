extends Character
class_name Adventurer

@onready var corner_check_area : Area2D = $Areas/CornerCheckArea
@onready var grab_shape : CollisionShape2D = $GrapShape
@onready var hud : PlayerHUD = $PlayerHUD


var is_attacking := false
var is_crouching := false
var is_sliding := false
var double_jump_count := 1
var is_in_corner := false

func _ready() -> void:
	super._ready()
	SPEED = 150.0
	JUMP_VELOCITY = -300.0
	hud.init(max_damage_count, max_damage_count)


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_move()
	handle_jump()
	handle_attack()
	handle_crouch()
	handle_slide()

	move_and_slide()


func handle_move():
	direction = Input.get_axis("run_left", "run_right")
	update_direction()
	
	
#func update_direction():
	#if direction:
		#velocity.x = direction * SPEED * speed_scale
#
		#if not face_direction == direction:
			#if not is_in_corner:
				#face_direction = int(direction)
#
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#anim.flip_h = face_direction < 0

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
	
	
func reset_attributes():
	speed_scale = 1
	double_jump_count = 1
	gravity_scale = 1
	
func toggle_attack_shape(_enable: bool):
	await get_tree().create_timer(0.1).timeout
	attack_shape.disabled = false
	await get_tree().create_timer(0.1).timeout
	attack_shape.disabled = true


func _on_hurt(_force: float) -> void:
	if hud:
		hud.set_health(max_damage_count - damage_count)
	state_machine.on_child_transition("hurt")


func _on_player_hud_right_button_just_pressed(value: String) -> void:
	pass
