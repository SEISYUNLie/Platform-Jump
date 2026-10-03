extends Area2D

var body_in = false
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_in)
	body_exited.connect(_out)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	climb()

func _in(body):
	if body.is_in_group("player"):
		body_in = true
		player = body

func _out(body):
	if body.is_in_group("player"): 
		body_in = false
		player.is_climbing = false
		player = null



func climb():
	if player == null:
		return
 
	if player.is_in_group("player") and Input.is_action_pressed("balance"):
		if Input.is_action_pressed("jump"):
			player.is_climbing = false
			player.velocity.y = -80 
			return 
		if Input.is_action_pressed("squat"):
			player.is_climbing = false
			player.velocity.y = 80 
			return 
		player.reset_jump()
		player.is_climbing = true
		player.velocity.y = 0
	else:
		player.is_climbing = false
