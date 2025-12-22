extends Node2D
var Player = preload("res://Scenes/player.tscn")
var Camera = preload("res://Scenes/camera.tscn")

var rng:RandomNumberGenerator = RandomNumberGenerator.new()

var enemy_directory = "res://Scenes/enemies/level 1/"
var enemy_list:Array = [] ##list of enemy scenes to shuffle

var enemies_in_scene:int = 10##number of enemies on screen, increase this and enemy total for more madness
var enemys_per_level:int = 100##total number of enemies in level, can just decrease this each time an enemy is spawned
@onready var node_containing_enemies: Node2D = $EnemyList##put enemies here to count them
@onready var enemy_spawner: Timer = $Timers/EnemySpawner##spawn enemies on timeout

@onready var player_spawn_position: Marker2D = $SpawnPosition

func _ready() -> void:
	GM.spawn_player(self, player_spawn_position.position)
	GM.spawn_cam(self, player_spawn_position.global_position)
	get_enemy_list()
	
func on_exit_scene():## must do this first before changing scene
	remove_child(GM.player)
	remove_child(GM.camera)
	
func spawn_enemy():
	if node_containing_enemies.get_child_count() < enemies_in_scene and enemies_in_scene < enemys_per_level:
		var spawn_number = enemies_in_scene - node_containing_enemies.get_child_count()
		for e in spawn_number:
			if enemy_list.is_empty():
				get_enemy_list()
			enemy_list.shuffle()
			var spawn_location = get_spawn_position()
			if spawn_location != null:
				var spawned_enemy = load("res://Scenes/enemies/level 1/" + enemy_list[0])
				var enemy  = spawned_enemy.instantiate()
				enemy.position = spawn_location
				node_containing_enemies.add_child(enemy)
				enemys_per_level -= 1

func get_spawn_position():
	var spawn_location:Vector2 = Vector2(rng.randi_range(-300, 300), rng.randi_range(300, -300))
	if abs(spawn_location - GM.player.global_position) > Vector2(100,100):
		return spawn_location
	else:get_spawn_position()

func get_enemy_list():##gives a count of files in directory, next rng from 0-size
	var dir = DirAccess.open(enemy_directory)
	if dir == null:
		pass
	else:
		dir.list_dir_begin()
		var enemy_name = dir.get_next()
		while enemy_name != "":
			if !dir.current_is_dir():
				enemy_list.append(enemy_name)
			enemy_name = dir.get_next()
	dir.list_dir_end()
	
func _on_enemy_spawner_timeout() -> void:
	print("timeout")
	spawn_enemy()
