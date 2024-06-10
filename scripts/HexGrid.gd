extends Node2D

const HEXAGON_SCENE_PATH = "res://Scenes/hex_node.tscn"
const RADIUS = 50.0

# Preload the hex scene
var hexagon_scene = preload(HEXAGON_SCENE_PATH)

# Size of the grid
const GRID_WIDTH = 5
const GRID_HEIGHT = 8

#Calculate hex dimensions
var hex_width = RADIUS * sqrt(3)
var hex_height = RADIUS * 2
var vertical_spacing = hex_height

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_hex_grid(GRID_WIDTH, GRID_HEIGHT)

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
