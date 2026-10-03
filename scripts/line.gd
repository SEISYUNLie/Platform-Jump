extends StaticBody2D

var collision = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision = $CollisionShape2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if collision and Input.is_action_pressed("balance"):
		collision.disabled = false
	else:
		collision.disabled = true
