extends Camera2D

func _ready() -> void:
	GM.spawn_ui(self)
	##places at top of viewport

func _process(delta: float) -> void:
	global_position = GM.player.global_position
