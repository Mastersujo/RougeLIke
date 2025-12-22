extends CharacterBody2D

var health = 100
var speed:float = 35.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = move_toward(global_position.x, GM.player.global_position.x, speed * delta)
	global_position.y = move_toward(global_position.y, GM.player.global_position.y, speed * delta)

func _physics_process(_delta: float) -> void:
	move_and_slide()  # Move character with collision detection
