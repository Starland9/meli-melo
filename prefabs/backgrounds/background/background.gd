extends Node2D

var scale_factor := 1.2

func _ready() -> void:
	var t := 0.0

	for child in get_children():
		if child is Parallax2D:
			child.get_child(0).scale = Vector2.ONE * scale_factor
			child.scroll_scale = Vector2.ONE * t * scale_factor
			t += .2

			child.repeat_size = Vector2(1024, 346) * scale_factor
