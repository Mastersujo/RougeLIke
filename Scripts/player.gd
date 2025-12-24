extends CharacterBody2D
var health:int = 10
@export var PlayerSpeed:float = 90.0
@onready var weapon: Node2D = $Weapon
var weapon_damage = 50
@onready var attack_timer: Timer = $Timers/AttackTimer
@onready var hurt_timer: Timer = $Timers/HurtTimer
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	add_to_group("Player")

func _physics_process(delta: float) -> void:
	rotate_weapon()
	get_input(delta)
	move_and_slide() 

func get_input(delta):
	# Returns a normalized vector from the movement keys (WASD/Arrow keys)
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * PlayerSpeed  # Apply speed to movement
	
func rotate_weapon():
	weapon.look_at((get_global_mouse_position()))

func damaged(damage):
	if hurt_timer.is_stopped():
		sprite.self_modulate = Color.RED
		hurt_timer.start()
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

func _on_hurt_timer_timeout() -> void:
	sprite.self_modulate = Color.WHITE
