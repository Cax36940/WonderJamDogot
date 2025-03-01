extends Node2D

const color: = Color(0.8, 0.8, 0.8, 0.1)

@onready var camera: Camera2D = $"/root/Main/World/Camera"
@onready var viewport: Viewport = get_viewport()
@onready var grid_cell_size: int = $"/root/Main/World".GRID_CELL_SIZE
var grid_size: Vector2

func _draw():
	var vp_size: Vector2 = viewport.get_visible_rect().size
	var cam_pos: Vector2 = camera.position
	var vp_right: float = vp_size.x * camera.zoom.x
	var vp_bottom: float = vp_size.y * camera.zoom.y
	
	var leftmost: float = -vp_right + cam_pos.x
	var topmost: float = -vp_bottom + cam_pos.y
	
	var left: float = ceil(leftmost / grid_cell_size) * grid_cell_size
	var bottommost : float = vp_bottom + cam_pos.y
	grid_size.x = vp_size.x / camera.zoom.x + 1
	for x in range(0, grid_size.x):
		draw_line(Vector2(left, topmost), Vector2(left, bottommost), color)
		left += grid_cell_size

	var top: float = ceil(topmost / grid_cell_size) * grid_cell_size
	var rightmost: = vp_right + cam_pos.x
	grid_size.y = vp_size.y / camera.zoom.y + 1
	for y in range(0, grid_size.y):
		draw_line(Vector2(leftmost, top), Vector2(rightmost, top), color)
		top += grid_cell_size
