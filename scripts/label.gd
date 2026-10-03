extends Label

var time: float = 0.0



func _process(delta):
	time += delta
	var c = Color.from_hsv(fmod(time, 1.0), 1.0, 1.0)
	add_theme_color_override("font_color", c)
