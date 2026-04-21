extends State
class_name GroundedState

func physics_update(_delta: float):
	if not player.is_on_floor():
		transitioned.emit("air")
