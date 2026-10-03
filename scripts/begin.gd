extends Area2D

var body_in = false
@export var hint:Label 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_in)
	body_exited.connect(_out)
	hint.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _in(body):
	if body.is_in_group("player"):
		hint.visible = true
		
func _out(body):
	if body.is_in_group("player"):
		hint.visible = false
