extends GroundedState

func enter():
	anim.play("run")

func physics_update(_delta: float):
	super.physics_update(_delta)

	if not player.direction:
		transitioned.emit("idle")
