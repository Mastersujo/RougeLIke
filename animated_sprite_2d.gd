extends StaticBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var attack_box: Node2D = $AttackBox
@onready var player_hurt: Area2D = $AttackBox/PlayerHurt
var attack_damage:int = 1
@onready var hit_start: Timer = $Timers/HitStart
@onready var attack_cd: Timer = $Timers/AttackCD
var rng:RandomNumberGenerator = RandomNumberGenerator.new()
var self_name:String
var health = 0
var max_health:int = 100
var speed:float = 35.0
var weight:float = .1

@onready var hurt_flasher: Timer = $Timers/HurtFlasher

func _ready() -> void:
	add_to_group("Enemy")
	health = max_health
	speed += rng.randi_range(-5, 5)
	
func _physics_process(delta: float) -> void:
	if GM.player.health > 0:
		attacking()
		facing_dir()
		mover(delta)
	
func mover(delta):
	if abs(global_position.y - GM.player.global_position.y) > 16:
		self.global_position.y = move_toward(global_position.y, lerp(global_position.y, GM.player.global_position.y, weight), delta * speed)
	if abs(global_position.x - GM.player.global_position.x) > 16:
		self.global_position.x = move_toward(global_position.x, lerp(global_position.x, GM.player.global_position.x, weight), delta * speed)

func facing_dir():##controls attack box facing and sprite facing
	attack_box.look_at(GM.player.global_position)
	if global_position.x < GM.player.global_position.x:
		sprite.flip_h = true
	elif global_position.x > GM.player.global_position.x:
		sprite.flip_h = false

func attacking():##attacks after a set period of time allowing player to move before the attack
	if attack_cd.is_stopped() and hit_start.is_stopped():
		for t in player_hurt.get_overlapping_areas():
			var target = t.get_parent()
			if target.is_in_group("Player"):
				hit_start.start()

func damage_player():#on hitting the player
	if attack_cd.is_stopped():
		for t in player_hurt.get_overlapping_areas():
				var target = t.get_parent()
				if target.is_in_group("Player"):
					target.damaged(attack_damage - GM.player_stats["defense"])
					attack_cd.start()

func damaged(damage):#being hurt
	sprite.self_modulate = Color.RED
	hurt_flasher.start()
	health -= damage
	if health <= 0:
		visible = false
		sprite.self_modulate = Color.WHITE
		GM.enemy_spawn_pool.append(self)
		self.reparent(get_tree().current_scene.idle_enemies)
		get_tree().current_scene.complete_level()
		process_mode = Node.PROCESS_MODE_DISABLED
		
func _on_hurt_flasher_timeout() -> void:
	sprite.self_modulate = Color.WHITE

func _on_hit_start_timeout() -> void:##starts the actual attack
	damage_player()
