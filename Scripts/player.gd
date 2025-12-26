extends CharacterBody2D
var health:int = 0
var max_health:int = 10
@export var PlayerSpeed:float = 3400.0
@onready var weapon: Node2D = $Weapon
var weapon_damage = 50
var base_crit_chance:int = 50
var max_crit_chance:int = 1000
var rng:RandomNumberGenerator = RandomNumberGenerator.new()
@onready var attack_timer: Timer = $Timers/AttackTimer
@onready var hurt_timer: Timer = $Timers/HurtTimer
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	add_to_group("Player")
	health = max_health

func _physics_process(delta: float) -> void:
	rotate_weapon()
	get_input(delta)
	move_and_slide() 

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = (input_direction * (PlayerSpeed + GM.player_stats["speed"])) * delta
	
func rotate_weapon():
	weapon.look_at((get_global_mouse_position()))

func damaged(damage):
	var crit_chance = rng.randi_range(0, max_crit_chance)
	
	if hurt_timer.is_stopped():
		sprite.self_modulate = Color.RED
		hurt_timer.start()
		if crit_chance <= crit_chance + GM.player_stats["crit_chance"]:
			health -= (damage * GM.player_stats["crit_damage"])
		health -= damage
		if health <= 0:
			print("dead")
			visible = false
		GM.ui_controller.update_health()

func _on_attack_timer_timeout() -> void:
	var targets = weapon.get_child(0).get_overlapping_areas()
	if !targets.is_empty():
		for target in targets:
			if target.get_parent().is_in_group("Enemy"):
				target.get_parent().damaged(weapon_damage + GM.player_stats["damage"])

func _on_hurt_timer_timeout() -> void:
	sprite.self_modulate = Color.WHITE
