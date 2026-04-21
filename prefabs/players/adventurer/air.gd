extends State

func enter():
	anim.play("jump")

func physics_update(_delta: float):
	if player.is_on_floor():
		transitioned.emit("idle")
