extends Area2D

@export var wall: Node2D
@export var ok:Sprite2D
@export var nook:Sprite2D
@export var label: Label

var body_in = false
var pressed = false

func _ready():
	add_to_group("button")
	body_entered.connect(_in)
	body_exited.connect(_out)
	nook.visible = false
	label.visible = false
	
	
func _process(delta: float) -> void:
	press()

func press():
	if body_in and Input.is_action_just_pressed("interact") and not pressed:
		wall.queue_free()
		nook.visible = true
		ok.visible = false
		pressed = true
		label.visible = true
		get_tree().create_timer(1).timeout.connect(off)

func _in(body):
	if body.is_in_group("player"):
		body_in = true
	
func _out(body):
	if body.is_in_group("player"):
		body_in = false

func off():
	label.visible = false
	
