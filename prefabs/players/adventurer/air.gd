extends State

var has_touch_wall := false
var touch_wall_face_direction := 0
var can_jump_wall := false

func enter():
	player.is_sliding = false
	player.speed_scale = 1
	player.toogle_corner_grab(false)
	anim.play("jump")

func physics_update(_delta: float):
	if player.is_on_wall_only():
		var bodies := player.corner_check_area.get_overlapping_bodies()
		if bodies.any(_is_tilemap_layer):
			player.toogle_corner_grab(false)
			has_touch_wall = true
			touch_wall_face_direction = player.face_direction
		else:
			player.toogle_corner_grab(true)


	if player.velocity.y > 0:
		anim.play("fall")

	if player.is_on_floor():
		transitioned.emit("idle")

	handle_double_jump()

func handle_double_jump():
	if Input.is_action_just_pressed("jump"):

		can_jump_wall = has_touch_wall and player.face_direction != touch_wall_face_direction

		if can_jump_wall:
			wall_jump()
		else:
			double_jump()


func wall_jump():
	has_touch_wall = false
	player.velocity.y = player.JUMP_VELOCITY
	anim.play("corner_jump")


func double_jump():
	if player.double_jump_count > 0:
		player.double_jump_count -= 1
		player.velocity.y = player.JUMP_VELOCITY
		anim.play("roulade")

func _is_tilemap_layer(node: Node2D):
	return node is TileMapLayer
