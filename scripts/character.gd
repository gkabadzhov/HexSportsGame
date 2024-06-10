extends Node2D

var selected = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if get_global_mouse_position().distance_to(global_position) < 25:
			selected = true
		else:
			selected = false

func move_to_position(new_position: Vector2):
	position = new_position
	selected = false
