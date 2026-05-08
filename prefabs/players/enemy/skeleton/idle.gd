extends EnemyState

func enter():
	super.enter()
	
	enemy.play_anim("idle")

func physics_update(_delta: float):
	super.physics_update(_delta)

	if enemy.direction:
		transitioned.emit("walk")
