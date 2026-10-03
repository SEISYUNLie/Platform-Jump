extends Area2D

@export var label:Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(win)
	label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win(body):
	if body.is_in_group("player"):
		label.visible = true
		body.set_physics_process(false)
		body.velocity = Vector2.ZERO
