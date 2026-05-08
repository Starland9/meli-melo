@abstract
class_name Character
extends CharacterBody2D

var SPEED := 300.0
var JUMP_VELOCITY := -400.0

@export var anim : AnimatedSprite2D

var direction : float = 0
@onready var face_direction : int = int(direction)
var gravity_scale := 0.1
var speed_scale := 1.0

@export var audio_player : AudioStreamPlayer2D

func update_direction():
	if direction:
		velocity.x = direction * SPEED * speed_scale
		
		if not face_direction == direction:
			face_direction = 1 if direction > 0 else -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	anim.flip_h = face_direction < 0


func play_anim(anim_name: StringName = &"", custom_speed: float = 1.0):
	anim.play(anim_name, custom_speed)


func play_sfx(sound: AudioStream, from_position: float = 0.0):
	var audio_player_2 := AudioStreamPlayer2D.new()
	add_child(audio_player_2)
	audio_player_2.stream = sound
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
