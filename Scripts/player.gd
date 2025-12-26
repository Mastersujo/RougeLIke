extends CharacterBody2D
<<<<<<< Updated upstream

@export var PlayerSpeed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
=======
var health:int = 0
var max_health:int = 10
@export var PlayerSpeed:float = 200.0
@onready var weapon: Node2D = $Weapon
var weapon_damage = 50
@onready var attack_timer: Timer = $Timers/AttackTimer

func _ready() -> void:
	add_to_group("Player")
	health = max_health
	

func _physics_process(delta: float) -> void:
	rotate_weapon()
	get_input(delta)
	move_and_slide() 
>>>>>>> Stashed changes

func get_input(delta):
	# Returns a normalized vector from the movement keys (WASD/Arrow keys)
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * PlayerSpeed  # Apply speed to movement
<<<<<<< Updated upstream

func _physics_process(_delta: float) -> void:
	get_input()       # Update velocity from input
	move_and_slide()  # Move character with collision detection
=======
	
func rotate_weapon():
	weapon.look_at((get_global_mouse_position()))

func damaged(damage):
	health -= damage
	if health <= 0:
		print("dead")
		queue_free()

func _on_attack_timer_timeout() -> void:
	var targets = weapon.get_child(0).get_overlapping_areas()
	if !targets.is_empty():
		for target in targets:
			if target.get_parent().is_in_group("Enemy"):
				target.get_parent().damaged(weapon_damage)
>>>>>>> Stashed changes
