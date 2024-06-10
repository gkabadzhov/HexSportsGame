extends Polygon2D

const RADIUS = 50.0
const OUTLINE_WIDTH = 2.0

@onready var outline_polygon = $OutlinePolygon

# Called when the node enters the scene tree for the first time.
func _ready():
	set_hexagon_shape(RADIUS, OUTLINE_WIDTH)# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta):
	pass

func set_hexagon_shape(radius: float, outline_width: float):
	var points = PackedVector2Array()
	for i in range(6):
		var angle = PI / 3 * i
		points.append(Vector2(radius * cos(angle), radius * sin(angle)))
	polygon = points
	
	#Create outline to each hex for readability
	var outline_points = PackedVector2Array()
	for i in range(6):
		var angle = PI / 3 * i
		outline_points.append(Vector2((radius + outline_width) * cos(angle), (radius + outline_width) * sin(angle)))
	outline_polygon.polygon = outline_points
	outline_polygon.color = Color(0,0,0)
