extends State
class_name GroundedState

func enter() -> void:
	player.hurt.connect(_on_player_hurt)

func physics_update(_delta: float):
	if player.is_in_corner:
		transitioned.emit("corner")

	elif not player.is_on_floor():
		transitioned.emit("air")

	else:
		if player.is_attacking:
			transitioned.emit("attack")

		elif player.is_sliding:
			transitioned.emit("slide")

		elif player.is_crouching:
			transitioned.emit("crouch")

func _on_player_hurt(force: float):
	print("aie ", force)
	transitioned.emit("hurt")
