extends Control
@onready var health_bar: TextureProgressBar = $HealthBar

func _ready() -> void:
	update_health()
	##places hp bar at top
	health_bar.global_position.y = int(get_tree().current_scene.get_viewport_rect().size.y / 2 - get_tree().current_scene.get_viewport_rect().size.y / 2) + 6

func update_health():
	health_bar.max_value = GM.player.max_health
	health_bar.value = GM.player.health
