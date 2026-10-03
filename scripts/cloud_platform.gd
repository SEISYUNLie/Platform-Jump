extends StaticBody2D

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var area2D = $Area2D

var on_top = false
var player:Node2D = null
var blink_timer = 0.6
var is_run = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	$Area2D.body_entered.connect(beicai)
	$Area2D.body_exited.connect(left)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_run:
		blink_timer -= delta
		var blink = fmod(blink_timer, 0.2)
		modulate.a = 0.5 if blink < 0.1 else 1.0

func beicai(body):
	if body.is_in_group("player") and not is_run:
		is_run = true
		on_top = true
		get_tree().create_timer(0.6).timeout.connect(disappear)#控制真正消失
		
func left(body):
	on_top = false
	modulate.a = 1.0
	blink_timer = 0.6

	is_run = false
		

func disappear():
	if not on_top:
		return	
	area2D.monitoring = false
	collision.set_deferred("disabled", true)   
	sprite.visible = false 
	get_tree().create_timer(1.5).timeout.connect(reappear)                    

func reappear():
	collision.set_deferred("disabled", false)  
	sprite.visible = true                   
	area2D.monitoring = true
	blink_timer = 0.6
	is_run = false
