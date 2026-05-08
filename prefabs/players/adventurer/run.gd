extends GroundedState

const run_sound := preload("res://assets/audio/sfx/player/2D_character_run_ste_#3-1778241199068.wav")

func enter():
	player.reset_attributes()
	player.play_sfx_loop(run_sound)
	player.play_anim("run")

func physics_update(_delta: float):
	super.physics_update(_delta)

	if not player.direction:
		transitioned.emit("idle")

func exit():
	super.exit()
	
	player.stop_sfx_loop()
