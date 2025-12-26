extends Control
@onready var health_bar: TextureProgressBar = $HealthBar

func _ready() -> void:
	update_health()
	
func update_health():
	health_bar.max_value = GM.player.max_health
	health_bar.value = GM.player.health
