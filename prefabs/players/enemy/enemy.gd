extends Character
class_name Enemy

signal player_entered()
signal player_exited()


@export var player : CharacterBody2D
@export var player_area : Area2D
@export var blood_particle : CPUParticles2D


func _ready() -> void:
	super._ready()
	SPEED = 70
	gravity_scale = 2
	
	player_area.body_entered.connect(_on_player_area_body_entered)
	player_area.body_exited.connect(_on_player_area_body_exited)
	
	
func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	
	if damage_count < max_damage_count:
		if player:
			direction = position.direction_to(player.position).x
	else:
		direction = 0
		die.emit()
		
	update_direction()
	move_and_slide()
		

func get_player_distance():
	return player.global_position.distance_to(global_position)

func _on_player_area_body_entered(body: Node2D):
	if body is Adventurer:
		player = body
		player_entered.emit()

func _on_player_area_body_exited(body: Node2D):
	if body is Adventurer:
		player = null
		player_exited.emit()
