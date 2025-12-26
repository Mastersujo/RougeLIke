extends Camera2D

func _ready() -> void:
	GM.spawn_ui(self)
	GM.ui_controller.global_position.y = -312
