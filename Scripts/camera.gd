extends Camera2D
var margin_offset:int = 6

func _ready() -> void:
	GM.spawn_ui(self)
	GM.ui_controller.global_position.y = -(get_tree().current_scene.get_viewport_rect().size.y / 2) + (get_tree().current_scene.get_viewport_rect().size.y / 2) + margin_offset 
	#GM.ui_controller.global_position.x = get_tree().current_scene.get_viewport_rect().size.x / 2
	print(global_position)
	
func _process(delta: float) -> void:
	global_position = GM.player.global_position
