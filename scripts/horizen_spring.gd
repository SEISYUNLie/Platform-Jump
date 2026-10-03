extends Area2D

var ok = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_in)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func  _in(body):
	if body.is_in_group("player")  and ok :
		body.velocity.x = 300
		body.reset_jump()
		ok = false
		get_tree().create_timer(0.2).timeout.connect(reset)
		
func reset():
	ok = true
