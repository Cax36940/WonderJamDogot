extends Node2D

@onready var camera : Camera2D = $Camera
@onready var mouse_object_container : Node2D = $MouseObjectContainer
@onready var grid_object_container : Node2D = $GridObjectContainer

var default_scene = preload("res://obstacle/basic_wall.tscn")

const GRID_CELL_SIZE : int = 16
const GRID_HALF_CELL_SIZE : int = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.enabled = true
	mouse_object_container
	var instance : GridObject = default_scene.instantiate()
	instance.modulate.a = 0.5
	mouse_object_container.add_child(instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event is InputEventMouseMotion:
		if mouse_object_container.get_child_count() > 0:
			mouse_object_container.get_child(0).position = align_on_grid(get_global_mouse_position())
			mouse_object_container.visible = is_pos_free(get_global_mouse_position())
			
	if Input.is_action_just_pressed("mouse_click"):
		if mouse_object_container.get_child_count() > 0 and is_pos_free(get_global_mouse_position()):
			var instance : GridObject = mouse_object_container.get_child(0).duplicate()
			instance.modulate.a = 1.0
			grid_object_container.add_child(instance)
			
			
func align_on_grid(pos : Vector2) :
	var ret : Vector2
	if pos.x < 0:
		pos.x -= GRID_CELL_SIZE
	
	if pos.y < 0:
		pos.y -= GRID_CELL_SIZE
		
	ret.x = int(pos.x) - (int(pos.x) % GRID_CELL_SIZE) + GRID_HALF_CELL_SIZE
	ret.y = int(pos.y) - (int(pos.y) % GRID_CELL_SIZE) + GRID_HALF_CELL_SIZE
	return ret

func is_pos_free(pos : Vector2):
	for child : GridObject in grid_object_container.get_children():
		var min_x = child.position.x - child.width * GRID_HALF_CELL_SIZE
		var max_x = child.position.x + child.width * GRID_HALF_CELL_SIZE
		var min_y = child.position.y - child.height * GRID_HALF_CELL_SIZE
		var max_y = child.position.y + child.height * GRID_HALF_CELL_SIZE
		if min_x <= pos.x and pos.x < max_x and min_y <= pos.y and pos.y < max_y :
			return false
		
	return true	
