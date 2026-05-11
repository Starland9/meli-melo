@abstract
class_name Enemy
extends Character

signal player_entered()
signal player_exited()
signal hit()
signal die()

@export var player : CharacterBody2D
@export var player_area : Area2D
@export var hitbox : Area2D
@export var shape : CollisionShape2D
@export var blood_particle : CPUParticles2D
@export var damage_count := 1

func _ready() -> void:
	SPEED = 70
	gravity_scale = 2
	
	player_area.body_entered.connect(_on_player_area_body_entered)
	player_area.body_exited.connect(_on_player_area_body_exited)
	
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	
	
func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	
	#if not player:
		#return
		
	if damage_count > 0:
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
		
func _on_hitbox_area_entered(area: Area2D):
	if area is Weapon:
		damage_count -= 1
		print(damage_count)
		hit.emit()
		
