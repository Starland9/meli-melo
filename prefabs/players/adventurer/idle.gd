extends GroundedState

func enter():
	player.reset_attributes()
	player.play_anim("idle")

func physics_update(_delta: float):
	super.physics_update(_delta)

	if player.direction:
		transitioned.emit("run")
