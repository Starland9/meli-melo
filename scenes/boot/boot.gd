extends Control

@onready var anim_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim_player.play("entrance")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	goto_hub()


func goto_hub():
	get_tree().change_scene_to_file("res://scenes/hub/hub.tscn")
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		goto_hub()
