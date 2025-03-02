extends Camera2D

var width : float = 0.
var height : float = 0.

var min_x : float = 0.
var max_x : float = 0.
var min_y : float = 0.
var max_y : float = 0.

var mouse_last_position : Vector2 = Vector2.ZERO

var initial_position : Vector2 = Vector2.ZERO

var target_zoom : Vector2 = Vector2.ONE
# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	
	min_x = 0
	max_x = initial_position.x * 2
	min_y = 0
	max_y = initial_position.y * 2
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("camera_zoom_in"):
		zoom *= 1.1
		if zoom.x > 2 :
			zoom = Vector2(5., 5.)
	if Input.is_action_just_pressed("camera_zoom_out"):
		zoom /= 1.1
		if zoom.x < 0.5 :
			zoom = Vector2(0.5, 0.5)
	
	
	if Input.is_action_just_pressed("mouse_move"):
		mouse_last_position = get_global_mouse_position()
		
	if event is InputEventMouseMotion :
		if Input.is_action_pressed("mouse_move"):
			var mouse_velocity : Vector2 = get_global_mouse_position() - mouse_last_position
			#min_x = initial_position.x - 100 * zoom.x * 5
			#max_x = initial_position.x + 100 * zoom.x * 5
			#min_y = initial_position.y - 100 * zoom.y * 5
			#max_y = initial_position.y + 100 * zoom.y * 5
			position.x = clamp(position.x - mouse_velocity.x, min_x, max_x)
			position.y = clamp(position.y - mouse_velocity.y, min_y, max_y)
			mouse_last_position = get_global_mouse_position()
			
