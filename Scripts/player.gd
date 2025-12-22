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
	
