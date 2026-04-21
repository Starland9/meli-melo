extends GroundedState

func enter():
	anim.play("idle")

func physics_update(_delta: float):
	super.physics_update(_delta)

	if player.direction:
		transitioned.emit("run")
