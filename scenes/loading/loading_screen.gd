extends Control
class_name LoadingScreen

signal loading_finished

@onready var progress_bar : ProgressBar = $TextureProgressBar/ProgressBar

func _ready() -> void:
	var tween := get_tree().create_tween().bind_node(progress_bar)
	tween.tween_property(progress_bar, "value", 100, 3).set_trans(Tween.TRANS_EXPO)
	$Control/AnimatedSprite2D.play("default")


func _on_progress_bar_value_changed(value: float) -> void:
	if value >= 100:
		loading_finished.emit()
		
