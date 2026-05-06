extends Node2D

@export var scale_factor := 1

func _ready() -> void:
	var t := 0.0

	for child in get_children():
		if child is Parallax2D:
			set_parallax_values(child, t)
			t += 0.2

	set_parallax_values(get_child(-1), 1 * scale_factor)

func set_parallax_values(parallax: Parallax2D, value: float):
	parallax.get_child(0).scale = Vector2.ONE * scale_factor
	parallax.scroll_scale.x = Vector2.ONE.x * value * scale_factor
	parallax.repeat_size.x = Vector2(1024, 346).x * scale_factor
