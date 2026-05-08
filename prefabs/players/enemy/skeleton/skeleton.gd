class_name Skeleton
extends Enemy

func _ready() -> void:
	super._ready()
	speed_scale = randf_range(1, 1.5)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	

func _on_player_entered() -> void:
	face_direction = ceil(direction)

func _on_player_exited() -> void:
	direction = 0
