extends CharacterBody2D

@export var PlayerSpeed:float = 200.0
@onready var weapon: Node2D = $Weapon
var weapon_damage = 50

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("LMB"):
		var targets = weapon.get_child(0).get_overlapping_areas()
		if !targets.is_empty():
			for target in targets:
				if target.get_parent().is_in_group("Enemy"):
					print(target)
					target.get_parent().damaged(weapon_damage)
		
	get_input()
	move_and_slide() 

func get_input():
	# Returns a normalized vector from the movement keys (WASD/Arrow keys)
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * PlayerSpeed  # Apply speed to movement
	
<<<<<<< Updated upstream
=======
func rotate_weapon():
	weapon.look_at(get_global_mouse_position())

func damaged(damage):
	var crit_chance = rng.randi_range(0, max_crit_chance)
	
	if hurt_timer.is_stopped():
		sprite.self_modulate = Color.RED
		hurt_timer.start()
		if crit_chance <= crit_chance + GM.player_stats["crit_chance"]:
			health -= (damage * GM.player_stats["crit_damage"])
		health -= damage
		if health <= 0:
			visible = false
			process_mode = Node.PROCESS_MODE_DISABLED
		GM.ui_controller.update_health()

func _on_attack_timer_timeout() -> void:
	weapon.get_child(0).attack()

func _on_hurt_timer_timeout() -> void:
	sprite.self_modulate = Color.WHITE
>>>>>>> Stashed changes
