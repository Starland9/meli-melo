extends EnemyState

const hit_sound := preload("res://assets/audio/sfx/skeleton/hurt_02.ogg")

func enter():
	super.enter()
	enemy.blood_particle.emitting = true
	enemy.play_anim("die")
	enemy.play_sfx(hit_sound)
	await enemy.anim.animation_finished

func physics_update(_delta: float):
	pass
