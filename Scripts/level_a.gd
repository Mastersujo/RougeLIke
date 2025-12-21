extends Node2D

var Player = preload("res://Scenes/player.tscn")
var Camera = preload("res://Scenes/camera.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var PlayerINS = Player.instantiate()
	var CamINS = Camera.instantiate()

	add_child(PlayerINS)
	add_child(CamINS)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
