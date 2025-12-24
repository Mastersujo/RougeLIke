extends Node
const PLAYER = preload("uid://ckudr8chj1kgo")
const CAMERA = preload("uid://ck0u4xiq2mfum")
var player:Node
var camera:Node

var enemy_spawn_pool:Array

func _ready() -> void:
	player = PLAYER.instantiate()
	camera = CAMERA.instantiate()

func spawn_player(current_scene :Node, spawn_position :Vector2):
	current_scene.add_child(player)
	player.position = spawn_position
	
func spawn_cam(current_scene:Node, spawn_position:Vector2):
	current_scene.add_child(camera)
