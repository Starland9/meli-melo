extends CanvasLayer
class_name PlayerHUD

signal right_button_pressed(value: String)
signal right_button_just_pressed(value: String)


@onready var health_progress_bar : TextureProgressBar = $Control/TextureRect/TextureProgressBar

func set_health(value: float):
	health_progress_bar.value = value

func init(value: float, max_value: float):
	health_progress_bar.value = value
	health_progress_bar.max_value = max_value


func _on_a_pressed() -> void:
	Input.action_press("jump")

func _on_b_pressed() -> void:
	right_button_pressed.emit("b")


func _on_x_pressed() -> void:
	Input.action_press("attack")


func _on_y_pressed() -> void:
	right_button_pressed.emit("d")


func _on_a_released() -> void:
	Input.action_release("jump")


func _on_x_released() -> void:
	Input.action_release("attack")
