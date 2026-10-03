extends Area2D

var is_following = false
var target = null
var floating = true
var float_amplitude: float = 5.0   # 浮动幅度（像素）
var float_speed: float = 3.0
var time = 0

func _ready():
	body_entered.connect(_on_body_entered)
	add_to_group("key")	

func _process(delta):
	time += delta
	if floating:
		position.y += sin(time * float_speed) * float_amplitude * delta
		

func _on_body_entered(body):
	if body.is_in_group("player") and not is_following:
		body.add_to_group("has_key")
		is_following = true
		target = body
		floating = false
		set_deferred("monitoring", false)
			
func _physics_process(delta: float) -> void:
	if is_following == true and target:
		global_position = global_position.lerp(target.global_position,0.2) 
