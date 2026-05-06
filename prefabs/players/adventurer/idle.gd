extends GroundedState

func enter():
	player.speed_scale = 1
	player.double_jump_count = 1
	player.gravity_scale = 1
	anim.play("idle")

func physics_update(_delta: float):
	super.physics_update(_delta)

	if player.direction:
		transitioned.emit("run")
