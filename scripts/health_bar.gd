extends HBoxContainer

@export var full_texture: Texture2D
@export var empty_texture: Texture2D
@export var max_health: int = 5

func update_health(current_health: int):
	for i in range(get_child_count()):
		var icon = get_child(i) as TextureRect
		if i < current_health:
			icon.texture = full_texture
		else:
			icon.texture = empty_texture
