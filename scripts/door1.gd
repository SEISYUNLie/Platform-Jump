extends Area2D
var body_in = false
var player:Node2D = null 
var key = null


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	player = get_tree().get_first_node_in_group("player")
	key = get_tree().get_first_node_in_group("key")

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
	if  is_in_group("unlocked") and Input.is_action_just_pressed("interact"):
		player.global_position  = Vector2(560,130)
		
	elif  Input.is_action_just_pressed("interact") and player.is_in_group("has_key"):
		player.global_position  = Vector2(560,130)
		add_to_group("unlocked")
		player.remove_from_group("has_key")	
		key.queue_free()
		
		
	
		 
		
		
