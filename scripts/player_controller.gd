extends CharacterBody2D

@export var fail_label_1:Label
@export var fail_label_2:Label
@export_category("移动参数")
@export var health_bar: HBoxContainer   # 在检查器里把 HealthBar 拖进来 
@export var double_press_interval := 0.3
@export var move_speed: float = 75.0
@export var acceleration: float = 600.0
@export var deceleration: float = 800.0
@export var jump_velocity: float = -190.0
var respownpoint = null
var health = 4
@export var invincibility_duration: float = 1.0  # 无敌持续时间（秒）
var is_invincible: bool = false                  # 是否处于无敌帧
var invincibility_timer: float = 0.0             
var is_climbing = false
var die = false
var huishoushang = true


@onready var sprite_jump: Sprite2D = $jump
@onready var sprite: Sprite2D = $idel

var flying : bool = false
var last_space_press_time := -1000
var jump_count = 0


func _ready():
	add_to_group("player")
	print(get_groups())
	respownpoint = global_position
	fail_label_1.visible = false
	fail_label_2.visible = false
	
func _physics_process(delta: float) -> void:

	if !flying:
		apply_gravity(delta)
		handle_jump()
	else:
		handle_vertical_movement(delta)
	
	handle_horizontal_movement(delta)
	update_sprite_direction()
	move_and_slide()

func _process(delta):
	#无敌帧
	if is_invincible:
		invincibility_timer -= delta
		
		# 图像闪烁：在 0.5 和 1.0 的透明度之间快速切换
		# 每 0.1 秒切换一次
		var blink = fmod(invincibility_timer, 0.2)
		modulate.a = 0.5 if blink < 0.1 else 1.0
		
		if invincibility_timer <= 0:
			is_invincible = false
			modulate.a = 1.0   
	#死亡ui
	if die and Input.is_action_just_pressed("reset"):
		health = 4
		global_position = respownpoint
		fail_label_1.visible = false
		fail_label_2.visible = false 
		die = false
		set_physics_process(true)
		health_bar.update_health(health)
		
	
			
func apply_gravity(delta: float) -> void:
	if not is_on_floor() and not is_climbing:
		velocity += get_gravity() * delta

func handle_vertical_movement(delta:float) -> void:
	var direction := Input.get_axis("squat", "jump")
	var target_speed := direction * jump_velocity
	
	if direction != 0.0:
		velocity.y = move_toward(
				velocity.y,
				target_speed,
				acceleration * delta
		)
	else:
		velocity.y = move_toward(
				velocity.y,
				0.0,
				acceleration * delta
		)
	
func handle_horizontal_movement(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	var target_speed := direction * move_speed

	if direction != 0.0:
		velocity.x = move_toward(
				velocity.x,
				target_speed,
				acceleration * delta
		)
	else:
		velocity.x = move_toward(
				velocity.x,
				0.0,
				deceleration * delta
		)

func handle_jump() -> void:
	if is_on_floor():
		jump_count = 0

	if Input.is_action_just_pressed("jump"):

		if jump_count <= 1:	
			velocity.y = jump_velocity
			jump_count =  jump_count + 1
		else:
			return
	
	#掉落动画
	if velocity.y < 0:
		sprite_jump.visible = true
		sprite.visible = false
	else:
		sprite_jump.visible = false
		sprite.visible = true

#保持平衡用		
func reset_jump():
	jump_count = 0
			
func update_sprite_direction() -> void:
	if velocity.x != 0.0:
		sprite.flip_h = velocity.x < 0.0
		sprite_jump.flip_h = velocity.x < 0.0

func take_damage(amount: int):
	# 处于无敌帧
	if is_invincible or not huishoushang:
		return
		
	health -= amount
	if health < 0:
		health = 0
	health_bar.update_health(health)
	
	var camera = get_tree().get_first_node_in_group("camera")
	if camera and camera.has_method("shake"):
		camera.shake(0.5)   # 0.5 是震动强度，可调
		
	# 进入无敌帧
	is_invincible = true
	invincibility_timer = invincibility_duration
	
	# 死亡处理
	if health == 0:
		fail_label_1.visible = true
		fail_label_2.visible = true
		die = true
		set_physics_process(false)
		

	

#还就那个创造模式		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly") and !event.is_echo():
		handle_space_pressed()
	
func handle_space_pressed() -> void:
	var current_time := Time.get_ticks_msec()
	var elapsed_time := current_time - last_space_press_time

	if elapsed_time <= double_press_interval * 1000.0 and is_in_group("has_shenqi"):
		flying = not flying
		last_space_press_time = -1000
	else:
		last_space_press_time = current_time
