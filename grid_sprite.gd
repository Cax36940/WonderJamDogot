extends Node2D

const color: = Color(0.8, 0.8, 0.8, 0.1)

@onready var camera: Camera2D = $"/root/World/Camera"
@onready var viewport: Viewport = get_viewport()
@onready var grid_size: int = $"/root/World".GRID_CELL_SIZE

func _draw():
	var vp_size: Vector2 = viewport.get_visible_rect().size
	var cam_pos: Vector2 = camera.position
	var vp_right: float = vp_size.x * camera.zoom.x
	var vp_bottom: float = vp_size.y * camera.zoom.y
	
	var leftmost: float = -vp_right + cam_pos.x
	var topmost: float = -vp_bottom + cam_pos.y
	
	var left: float = ceil(leftmost / grid_size) * grid_size
	var bottommost : float = vp_bottom + cam_pos.y
	for x in range(0, vp_size.x / camera.zoom.x + 1):
		draw_line(Vector2(left, topmost), Vector2(left, bottommost), color)
		left += grid_size

	var top: float = ceil(topmost / grid_size) * grid_size
	var rightmost: = vp_right + cam_pos.x
	for y in range(0, vp_size.y / camera.zoom.y + 1):
		draw_line(Vector2(leftmost, top), Vector2(rightmost, top), color)
		top += grid_size
