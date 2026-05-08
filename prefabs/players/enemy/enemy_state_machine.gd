class_name EnemyStateMachine
extends StateMachine

func _ready() -> void:
	await owner.ready
	for child in get_children():
		if child is State:
			child.player = owner
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state
