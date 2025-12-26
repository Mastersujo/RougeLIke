extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var attack_box: Node2D = $AttackBox
@onready var player_hurt: Area2D = $AttackBox/PlayerHurt
var attack_damage:int = 1
@onready var attack_cd: Timer = $Timers/AttackCD

var health = 100

@onready var hurt_flasher: Timer = $Timers/HurtFlasher

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
<<<<<<< Updated upstream
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()  # Move character with collision detection
=======
	add_to_group("Enemy")
	
func _physics_process(delta: float) -> void:
	attacking()
	facing_dir()
	mover(delta)
	move_and_slide()  # Move character with collision detection

	
func mover(delta):
	global_position.x = move_toward(global_position.x, GM.player.global_position.x, speed * delta)
	global_position.y = move_toward(global_position.y, GM.player.global_position.y, speed * delta)

func facing_dir():##controls attack box facing and sprite facing
	if global_position.y + 16 < GM.player.global_position.y:
		attack_box.position.x = 0
		attack_box.position.y = 12
	elif global_position.y - 16 > GM.player.global_position.y:
		attack_box.position.x = 0
		attack_box.position.y = -12
	elif global_position.x < GM.player.global_position.x:
		sprite.flip_h = true
		attack_box.position.x = 10
		attack_box.position.y = 0
	elif global_position.x > GM.player.global_position.x:
		sprite.flip_h = false
		attack_box.position.x = -10
		attack_box.position.y = 0
		

func attacking():
	if attack_cd.is_stopped():
		for t in player_hurt.get_overlapping_areas():
			var target = t.get_parent()
			if target.is_in_group("Player"):
				target.damaged(attack_damage)
				attack_cd.start()

func damaged(damage):
	sprite.self_modulate = Color.RED
	hurt_flasher.start()
	health -= damage
	if health <= 0:
		queue_free()

func _on_hurt_flasher_timeout() -> void:
	sprite.self_modulate = Color.WHITE
>>>>>>> Stashed changes
