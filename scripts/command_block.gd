extends Area2D


var is_following = false
var target = null
var floating = true
var float_amplitude: float = 5.0   # 浮动幅度（像素）
var float_speed: float = 3.0
var time = 0
var player = null
var triggered = false
@export var label:Label
@export var notch:Sprite2D
@export var block:Sprite2D
@export var Health_Bar:HBoxContainer

func _ready():
	body_entered.connect(_on_body_entered)
	add_to_group("block")	
	label.visible = false

func _process(delta):
	time += delta
	if floating:
		position.y += sin(time * float_speed) * float_amplitude * delta
	if player == null:
		return
	if player and player.is_in_group("has_shenqi") and triggered == false:
		label.visible = true
		floating = false
	if player.flying == true and not triggered:
		triggered = true
		label.visible = false
		notch.visible = true
		player.huishoushang = false
		Health_Bar.visible = false
		block.visible = false
		var tween = create_tween()
		tween.tween_property(notch, "modulate:a", 0.0, 0.5)
		tween.tween_callback(func():notch.visible = false)	
		get_tree().create_timer(0.5).timeout.connect(func():queue_free())
		
		

func _on_body_entered(body):
	if body.is_in_group("player") and not is_following:
		body.add_to_group("has_shenqi")
		player = body
		is_following = true
		target = body
		floating = false
		set_deferred("monitoring", false)
			
func _physics_process(delta: float) -> void:
	if is_following == true and target:
		global_position = global_position.lerp(target.global_position,0.2) 
