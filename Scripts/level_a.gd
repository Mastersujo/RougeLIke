extends Node2D

var Player = preload("res://Scenes/player.tscn")
var Camera = preload("res://Scenes/camera.tscn")
var Enemy  = preload("res://Scenes/Blue_Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var PlayerINS = Player.instantiate()
	var CamINS    = Camera.instantiate()
	var EnemyINS  = Enemy.instantiate()
	add_child(PlayerINS)
	add_child(CamINS)
	EnemyINS.global_position = Vector2(30,30)
	add_child(EnemyINS)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
