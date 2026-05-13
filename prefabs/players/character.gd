extends CharacterBody2D
class_name Character

signal hurt(force: float)
signal die()

var SPEED := 300.0
var JUMP_VELOCITY := -400.0

@export var anim : AnimatedSprite2D
@export var audio_player : AudioStreamPlayer2D
@export var hitbox : Area2D
@export var attack_shape : CollisionShape2D
@export var body_shape : CollisionShape2D
@export var state_machine: StateMachine
@export var speed_scale := 1.0

@onready var cam : Camera2D = get_viewport().get_camera_2d()
@onready var cam_start_pos : Vector2 = cam.global_position


var direction : float = 0
@onready var face_direction : int = int(direction)
var gravity_scale := 0.1
@export var max_damage_count := 5.0
var damage_count := 0.0


func _ready() -> void:
	hitbox.area_entered.connect(_on_hitbox_area_entered)


func update_direction():
	if direction:
		velocity.x = direction * SPEED * speed_scale
		
		if not face_direction == direction:
			face_direction = 1 if direction > 0 else -1
			attack_shape.position.x = face_direction * abs(attack_shape.position.x)
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	anim.flip_h = face_direction < 0


func play_anim(anim_name: StringName = &"", custom_speed: float = 1.0):
	anim.play(anim_name, custom_speed)


func play_sfx(sound: AudioStream, volume_db: float = 0.0, from_position: float = 0.0):
	var audio_player_2 := AudioStreamPlayer2D.new()
	add_child(audio_player_2)
	audio_player_2.stream = sound
	audio_player_2.volume_db = volume_db
	audio_player_2.play(from_position)
	await audio_player_2.finished
	audio_player_2.queue_free()


func play_sfx_loop(sound: AudioStream, from_position: float = 0.0):
	audio_player.stream = sound
	audio_player.play(from_position)


func stop_sfx_loop():
	audio_player.stop()
	
	
func apply_gravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_scale
		
		
func toggle_attack_shape(_enable: bool):
	pass

func toggle_body_shape(enable: bool):
	body_shape.disabled = !enable
	attack_shape.disabled = !enable
	
func _on_hitbox_area_entered(area: Area2D):
	if area is Weapon:
		damage_count += 1
		_hit_slop()
		_shake_camera()
		hurt.emit(area.force)

func _hit_slop():
	get_tree().paused = true
	await get_tree().create_timer(0.02).timeout
	get_tree().paused = false
		
func _shake_camera():
	randomize()
	var tween = get_tree().create_tween().bind_node(cam)
	var shake_factor := 5
	var shake_position = Vector2(randf_range(-shake_factor, shake_factor), randf_range(-shake_factor, shake_factor))
	var shake_time := 0.12
	tween.tween_property(cam, "position", cam.position - shake_position, shake_time).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(cam, "position", cam.position + shake_position, shake_time).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(cam, "position", Vector2.ZERO, shake_time).set_trans(Tween.TRANS_ELASTIC)

	
