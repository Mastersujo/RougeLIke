extends Node
const PLAYER = preload("uid://ckudr8chj1kgo")
const CAMERA = preload("uid://ck0u4xiq2mfum")
const UI = preload("uid://2t0lk5iluiib")

var player:Node
var camera:Node
var ui_controller:Node

var enemy_spawn_pool:Array

var player_stats:Dictionary = { ##add these to base player stats
	"damage":0, "magic_damage":0, "speed":0, "health":0, "defense":0, "crit_chance":0, "crit_damage":1.5
}

func _ready() -> void:
	player = PLAYER.instantiate()
	camera = CAMERA.instantiate()
	ui_controller = UI.instantiate()

func spawn_player(current_scene :Node, spawn_position :Vector2):
	current_scene.add_child(player)
	player.position = spawn_position
	
func spawn_cam(current_scene:Node, spawn_position:Vector2):
	current_scene.add_child(camera)

func spawn_ui(current_scene:Node):
	current_scene.add_child(ui_controller)
