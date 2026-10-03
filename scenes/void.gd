extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(take_damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(body):
	if body.is_in_group("player"):
		body.take_damage(1)
		if body.health <= 0:
			return
		body.global_position = body.respownpoint
