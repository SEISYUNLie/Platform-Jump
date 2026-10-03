extends Area2D

var body_in = false
var player:Node2D = null 

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _process(delta):
	if body_in:
		open()
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		body_in = true
		player = body
	
func _on_body_exited(body):
	if body.is_in_group("player"):
		body_in = false
		player = null
		
func open():
	if Input.is_action_just_pressed("interact"):
		player.global_position = Vector2(330,200)
