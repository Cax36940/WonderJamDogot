extends Camera2D

var width : float = 0.
var height : float = 0.

var min_x : float = 0.
var max_x : float = 0.
var min_y : float = 0.
var max_y : float = 0.

var mouse_last_position : Vector2 = Vector2.ZERO

var target_zoom : Vector2 = Vector2.ONE
# Called when the node enters the scene tree for the first time.
func _ready():
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	
	min_x = position.x - 0.5 * width
	max_x = position.x + 0.5 * width
	min_y = position.y - 0.5 * height
	max_y = position.y + 0.5 * height
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoom *= 1.1
		if zoom.x > 5 :
			zoom = Vector2(5., 5.)
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoom /= 1.1
		if zoom.x < 0.2 :
			zoom = Vector2(0.2, 0.2)
	
	
	if Input.is_action_just_pressed("mouse_move"):
		mouse_last_position = get_global_mouse_position()
		
	if event is InputEventMouseMotion :
		if Input.is_action_pressed("mouse_move"):
			var mouse_velocity : Vector2 = get_global_mouse_position() - mouse_last_position
			position.x = clamp(position.x - mouse_velocity.x, min_x, max_x)
			position.y = clamp(position.y - mouse_velocity.y, min_y, max_y)
			mouse_last_position = get_global_mouse_position()
			
