extends Node2D
var Player = preload("res://Scenes/player.tscn")
var Camera = preload("res://Scenes/camera.tscn")

var rng:RandomNumberGenerator = RandomNumberGenerator.new()

const Enemy = preload("uid://wwgshqeenkyn")
var enemy_directory = "res://Scenes/enemies/level 1/"
var enemy_list:Array = [] ##list of enemy scenes to shuffle
var no_of_enemies:int = 0


@onready var spawn_position: Marker2D = $SpawnPosition

func _ready() -> void:
	GM.spawn_player(self, spawn_position.position)
	GM.spawn_cam(self, spawn_position.global_position)
	get_enemy_list()
	spawnenemy()
	
func on_exit_scene():## must do this first before changing scene
	remove_child(GM.player)
	remove_child(GM.camera)
	
func spawnenemy():
	print(enemy_list)
	var spawned_enemy = load("res://Scenes/enemies/level 1/" + enemy_list[0])
	var enemy  = spawned_enemy.instantiate()
	var spawn_location:Vector2 = Vector2(rng.randi_range(0, 300), rng.randi_range(0, -300))
	enemy.global_position = spawn_location
	add_child(enemy)
	enemy_list.clear()

func get_enemy_list():##gives a count of files in directory, next rng from 0-size
	no_of_enemies = 0
	var dir = DirAccess.open(enemy_directory)
	if dir == null:
		pass
	else:
		dir.list_dir_begin()
		var enemy_name = dir.get_next()
		while enemy_name != "":
			if !dir.current_is_dir():
				enemy_list.append(enemy_name)
				no_of_enemies += 1
			enemy_name = dir.get_next()
	dir.list_dir_end()
	enemy_list.shuffle()
	print(no_of_enemies, " enemy in enemy list directory")
		
