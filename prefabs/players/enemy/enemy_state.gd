class_name EnemyState
extends State

var enemy : Enemy

func enter():
	enemy = player as Enemy

	if not enemy.hurt.is_connected(_on_enemy_hurt): enemy.hurt.connect(_on_enemy_hurt)
	if not enemy.die.is_connected(_on_enemy_die): enemy.die.connect(_on_enemy_die)

func _on_enemy_hurt(_force: float):
	pass
	
func _on_enemy_die():
	transitioned.emit("die")
