extends EnemyState

const die_sound := preload("res://assets/audio/sfx/skeleton/creature_roar_03.ogg")

func enter():
	super.enter()
	enemy.toggle_body_shape(false)
	enemy.gravity_scale = 0
	enemy.play_sfx(die_sound, 10)
	enemy.play_anim("die")
	await enemy.anim.animation_finished

func physics_update(_delta: float):
	pass
