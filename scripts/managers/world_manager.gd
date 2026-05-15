extends Node

@onready var loading_screen_scene : PackedScene = preload("res://scenes/loading/loading_screen.tscn")

func go_to_level(_level_id: int):
	var loading_screen := loading_screen_scene.instantiate() as LoadingScreen
	loading_screen.loading_finished.connect(_on_loading_finished)
	get_tree().change_scene_to_node(loading_screen)
	


func _on_loading_finished():
	get_tree().change_scene_to_file("res://scenes/playground/playground.tscn")
