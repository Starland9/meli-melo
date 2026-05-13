extends GroundedState

const slide_sound := preload("res://assets/audio/sfx/player/2D_character_sliding_#4-1778239654854.wav")

const SLIDE_TIME = .1
var slide_timer := Timer.new()

func _ready() -> void:
	add_child(slide_timer)
	slide_timer.wait_time = SLIDE_TIME
	slide_timer.one_shot = true
	slide_timer.timeout.connect(_on_slide_timer_timeout)

func _on_slide_timer_timeout():
	if player.is_on_floor():
		player.play_anim("stand")
		await player.anim.animation_finished
		player.is_sliding = false
		transitioned.emit("idle")

func enter():
	player.speed_scale = 2
	player.play_anim("slide")
	slide_timer.start()
	player.play_sfx(slide_sound, -20)


func physics_update(_delta: float):
	super.physics_update(_delta)
