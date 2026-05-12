extends Enemy
class_name Skeleton

const hit_sound := preload("res://assets/audio/sfx/skeleton/Hit.wav")



func _on_player_entered() -> void:
	face_direction = ceil(direction)


func _on_player_exited() -> void:
	direction = 0


func _on_hurt(force: float) -> void:
	blood_particle.emitting = true
	modulate_to_red()
	play_sfx(hit_sound)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position:x", position.x - force * face_direction, 0.1).set_trans(Tween.TRANS_BOUNCE)
	
func modulate_to_red():
	var num = 1 -  damage_count / max_damage_count
	modulate = Color(modulate.r, num, num)
