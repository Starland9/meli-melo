extends GroundedState

func enter():
	player.speed_scale = 0
	anim.play("corner_grab")

func physics_update(_delta: float):
	super.physics_update(_delta)

	handle_climp()


func handle_climp():
	if Input.is_action_just_pressed("jump"):
		anim.play("corner_climb")
		var tween = get_tree().create_tween().bind_node(player)
		tween.tween_property(player, "position", Vector2(0, -40), .2).as_relative()
		await tween.finished
		player.toogle_corner_grab(false)
		transitioned.emit("idle")
