extends Node2D

@onready var camera : Camera2D = $Camera
@onready var mouse_object_container : Node2D = $MouseObjectContainer
@onready var grid_object_container : Node2D = $GridObjectContainer

var basic_wall_scene = preload("res://obstacle/basic_wall.tscn")
var spikes_scene = preload("res://obstacle/spikes.tscn")

const GRID_CELL_SIZE : int = 16
const GRID_HALF_CELL_SIZE : int = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.enabled = true
	var instance : GridObject = spikes_scene.instantiate()
	instance.modulate.a = 0.5
	mouse_object_container.add_child(instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event is InputEventMouseMotion:
		if mouse_object_container.get_child_count() > 0:
			var object : GridObject = mouse_object_container.get_child(0)
			object.position = align_on_grid(get_global_mouse_position(), object.width, object.height)
			mouse_object_container.visible = is_pos_free(get_global_mouse_position(), object.width, object.height)
			if Input.is_action_pressed("mouse_click"):
				spawn_object_at_pos(get_global_mouse_position())
	if Input.is_action_just_pressed("mouse_click"):
		spawn_object_at_pos(get_global_mouse_position())
	
	if Input.is_action_just_pressed("mouse_cancel"):
		if mouse_object_container.get_child_count() > 0:
			mouse_object_container.get_child(0).queue_free()
			
			
func align_on_grid(pos : Vector2, width : int, height : int) :
	var ret : Vector2
	if pos.x < 0:
		pos.x -= GRID_CELL_SIZE
	
	if pos.y < 0:
		pos.y -= GRID_CELL_SIZE
		
	ret.x = int(pos.x) - (int(pos.x) % GRID_CELL_SIZE) + GRID_HALF_CELL_SIZE * width
	ret.y = int(pos.y) - (int(pos.y) % GRID_CELL_SIZE) + GRID_HALF_CELL_SIZE * height
	return ret

func is_pos_free(pos : Vector2, width : int, height : int):
	
	var aligned_pos : Vector2 = align_on_grid(pos, width, height)
	var max_aligned_pos : Vector2 = Vector2.ZERO
	max_aligned_pos.x = aligned_pos.x + width * GRID_CELL_SIZE
	max_aligned_pos.y = aligned_pos.y + width * GRID_CELL_SIZE
	
	for child : GridObject in grid_object_container.get_children():
		var min_x : float = child.position.x #- child.width * GRID_HALF_CELL_SIZE 
		var max_x : float = child.position.x  + (child.width) * GRID_CELL_SIZE
		var min_y : float = child.position.y #- child.height * GRID_HALF_CELL_SIZE
		var max_y : float = child.position.y  + (child.height ) * GRID_CELL_SIZE
		
		var min_pos : Vector2 = Vector2(min_x, min_y)
		var max_pos : Vector2 = Vector2(max_x, max_y)

		#print(overlap(aligned_pos, max_aligned_pos, min_pos, max_pos))
		if overlap(aligned_pos, max_aligned_pos, Vector2(min_x, min_y), Vector2(max_x, max_y)):
			return false
	return true	

func spawn_object_at_pos(pos : Vector2):
	if mouse_object_container.get_child_count() > 0 :
		var object : GridObject = mouse_object_container.get_child(0)
		if is_pos_free(pos, object.width, object.height):
			var instance : GridObject = object.duplicate()
			instance.modulate.a = 1.0
			grid_object_container.add_child(instance)

func overlap(min_pos1 : Vector2, max_pos1 : Vector2, min_pos2 : Vector2, max_pos2 : Vector2):
	if min_pos1.x > max_pos2.x or min_pos2.x > max_pos1.x :
		return false
		
	if min_pos1.y > max_pos2.y or min_pos2.y > max_pos1.y :
		return false
	
	return true
	
