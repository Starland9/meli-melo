extends GroundedState

var stop_attack_timer : Timer = Timer.new()
const MAX_COMBO := 3
var current_combo := 0

func _ready() -> void:
	init_stop_attack_timer()
	stop_attack_timer.one_shot = true

func init_stop_attack_timer():
	add_child(stop_attack_timer)
	stop_attack_timer.wait_time = .5
	stop_attack_timer.timeout.connect(_on_stop_attack_timer_timeout)

func _on_stop_attack_timer_timeout():
	player.is_attacking = false
	current_combo = 0
	transitioned.emit("idle")

func enter():
	stop_attack_timer.start()
	play_combo(current_combo)
	player.speed_scale = 0.1

func play_combo(idx: int):
	anim.play("attack_" + str(idx + 1))
	await anim.animation_finished

func physics_update(_delta: float):
	super.physics_update(_delta)

	if Input.is_action_just_pressed("attack"):
		current_combo += 1
		current_combo = current_combo % MAX_COMBO
		play_combo(current_combo)
		stop_attack_timer.start()
