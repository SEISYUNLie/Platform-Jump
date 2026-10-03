extends Area2D

var _in = false
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_up)
	body_exited.connect(out)
	player = get_tree().get_first_node_in_group("player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == null:
		return
	if player.is_in_group("player") and Input.is_action_pressed("jump") and _in:
		player.velocity.y = -80

func _up(body):
	if body.is_in_group("player"):
		_in = true
	

func out(body):
	if body.is_in_group("player"):
		_in = false
