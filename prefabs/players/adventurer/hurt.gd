extends GroundedState

func enter():
	player.speed_scale = 0
	player.play_anim("hurt")
	var tween = get_tree().create_tween().bind_node(player)
	tween.tween_property(player, "position:x", player.position.x - 50 * player.face_direction, 0.2).set_trans(Tween.TRANS_BOUNCE)
	await get_tree().create_timer(0.5).timeout
	transitioned.emit("idle")
	
func physics_update(_delta: float) -> void:
	pass
