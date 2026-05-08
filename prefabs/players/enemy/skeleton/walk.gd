extends EnemyState

func enter():
	super.enter()
	
	enemy.play_anim("walk")

func physics_update(_delta: float):
	super.physics_update(_delta)

	if not player.direction:
		transitioned.emit("idle")
