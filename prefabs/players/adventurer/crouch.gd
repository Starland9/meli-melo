extends GroundedState

func enter():
	player.speed_scale = 0
	anim.play("crouch")

func physics_update(_delta: float):
	super.physics_update(_delta)

	if not player.is_crouching:
		transitioned.emit("idle")
