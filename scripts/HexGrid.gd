extends Node2D

const HEXAGON_SCENE_PATH = "res://Scenes/hex_node.tscn"
const CHARACTER_SCENE_PATH = "res://Scenes/Character.tscn"
const RADIUS = 50.0

# Preload the hex scene
var hexagon_scene = preload(HEXAGON_SCENE_PATH)
var character_scene = preload(CHARACTER_SCENE_PATH)

# Size of the grid
const GRID_WIDTH = 5
const GRID_HEIGHT = 8

#Calculate hex dimensions
var hex_width = RADIUS * sqrt(3)
var hex_height = RADIUS * 2
var vertical_spacing = hex_height

var selected_character = null

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_hex_grid(GRID_WIDTH, GRID_HEIGHT)
	spawn_character(Vector2(5,5))

func generate_hex_grid(width: int, height: int):
	for x in range(width):
		for y in range(height):
			var hex_instance = hexagon_scene.instantiate()
			var pos_x = x * hex_width
			var pos_y = y * vertical_spacing

			# Offset every second column
			if x % 2 != 0:
				pos_y += hex_height / 2
				
			hex_instance.position = Vector2(pos_x, pos_y)
			add_child(hex_instance)

func spawn_character(grid_position: Vector2):
	var character_instance = character_scene.instantiate()
	var pos_x = grid_position.x * hex_width
	var pos_y = grid_position.y * vertical_spacing
	
	if int(grid_position.x) % 2 != 0:
		pos_y += vertical_spacing / 2
	
	character_instance.position = Vector2(pos_x, pos_y)
	add_child(character_instance)
	selected_character = character_instance
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if selected_character and selected_character.selected:
			var mouse_pos = get_global_mouse_position()
			var grid_pos = calculate_grid_position(mouse_pos)
			var new_pos = calculate_world_position(grid_pos)
			
			if is_adjacent(selected_character.position, new_pos):
				selected_character.move_to_position(new_pos)

func calculate_grid_position(world_position: Vector2) -> Vector2:
	var x = int(world_position.x / hex_width)
	var y = int(world_position.y / vertical_spacing)
	return Vector2(x, y)
	
func calculate_world_position(grid_position: Vector2) -> Vector2:
	var pos_x = grid_position.x * hex_width
	var pos_y = grid_position.y * vertical_spacing
	
	if int(grid_position.x) % 2 != 0:
		pos_y += vertical_spacing / 2
	
	return Vector2(pos_x, pos_y)
	
func is_adjacent(pos1: Vector2, pos2: Vector2) -> bool:
	var dx = abs(pos1.x - pos2.x)
	var dy = abs(pos1.y - pos2.y)
	return (dx <= hex_width and dy <= vertical_spacing) and not (dx == 0 and dy == 0)
	
