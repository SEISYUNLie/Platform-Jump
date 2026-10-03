extends Camera2D

@export var shake_strength: float = 8.0   
@export var shake_decay: float = 5.0      

var shake_amount: float = 0.0

func _ready():
	add_to_group("camera")
	

func _process(delta):
	if shake_amount > 0:
		shake_amount = max(shake_amount - shake_decay * delta, 0.0)
		
		offset.x = randf_range(-1, 1) * shake_strength * shake_amount
		offset.y = randf_range(-1, 1) * shake_strength * shake_amount
	else:
		offset = Vector2.ZERO

func shake(intensity: float = 1.0):
	shake_amount = clamp(shake_amount + intensity, 0.0, 1.0)
