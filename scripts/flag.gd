extends Area2D

@export var label:Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(set_spownpoint)
	body_exited.connect(out)
	label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_spownpoint(body):
	if body.is_in_group("player"):
		body.respownpoint = global_position
		label.visible = true

func out(body):
	if body.is_in_group("player"):
		get_tree().create_timer(1).timeout.connect(off)		
	
func off():
	label.visible = false
