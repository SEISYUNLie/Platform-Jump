extends Area2D

var button = null
var camera = null

func _ready():
	camera = get_tree().get_first_node_in_group("camera")
	button = get_tree().get_first_node_in_group("button")
	print("camera: ", camera, " button: ", button)
	body_entered.connect(update_camera)
	
func update_camera(body):
	print("有物体进入摄像机区域：", body.name)
	if not body.is_in_group("player"):
		return
	print("玩家进入，开始改摄像头限制")
	if button.pressed:
		camera.limit_left = -1465
		camera.limit_right = 450
		camera.limit_top = -235
		camera.limit_bottom = 270
	else:
		camera.limit_left = 0
		camera.limit_right = 450
		camera.limit_top = 0
		camera.limit_bottom = 290
		
