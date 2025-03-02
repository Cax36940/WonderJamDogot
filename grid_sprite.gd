extends Node2D

const color: = Color(0.8, 0.8, 0.8, 0.1)

@onready var camera: Camera2D = $"../Camera"
@onready var viewport: Viewport = get_viewport()
@onready var grid_size: int = $"..".GRID_CELL_SIZE

func _draw():
	var vp_size: Vector2 = viewport.get_visible_rect().size
	#var cam_pos: Vector2 = camera.position
	#var vp_right: float = vp_size.x * camera.zoom.x
	#var vp_bottom: float = vp_size.y * camera.zoom.y
	
	var leftmost: float = - (vp_size.x / camera.zoom.x + 1) * grid_size
	var topmost: float = - (vp_size.y / camera.zoom.y + 1) * grid_size
	
	var left: float = ceil(leftmost / grid_size) * grid_size
	var bottommost : float = (vp_size.y / camera.zoom.y + 1) * grid_size
	for x in range(0, vp_size.x / camera.zoom.x + 1):
		draw_line(Vector2(left, topmost), Vector2(left, bottommost), color)
		draw_line(Vector2(-left, topmost), Vector2(-left, bottommost), color)
		left += grid_size
	draw_line(Vector2(left, topmost), Vector2(left, bottommost), color)

	var top: float = ceil(topmost / grid_size) * grid_size
	var rightmost: = (vp_size.x / camera.zoom.x + 1) * grid_size
	for y in range(0, vp_size.y / camera.zoom.y + 1):
		draw_line(Vector2(leftmost, top), Vector2(rightmost, top), color)
		draw_line(Vector2(leftmost, -top), Vector2(rightmost, -top), color)
		top += grid_size
	draw_line(Vector2(leftmost, top), Vector2(rightmost, top), color)
