class_name EnemyState
extends State

var enemy : Enemy

func enter():
	enemy = player as Enemy

	if not enemy.hit.is_connected(_on_enemy_hit): enemy.hit.connect(_on_enemy_hit)
	if not enemy.die.is_connected(_on_enemy_die): enemy.die.connect(_on_enemy_die)

func _on_enemy_hit():
	pass
	
func _on_enemy_die():
	transitioned.emit("die")
