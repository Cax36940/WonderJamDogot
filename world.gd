extends Node2D

@onready var camera : Camera2D = $Camera
@onready var basic_grid_object: Node2D = $BasicGridObject

var default_scene = preload("res://obstacle/basic_wall.tscn")



const GRID_CELL_SIZE : int = 16

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	basic_grid_object.position.x += 1
	pass


func _input(event):
	if event is InputEventMouseButton:
		var instance = default_scene.instantiate()
		instance.position = align_on_grid(event.global_position)
		add_child(instance)

func align_on_grid(pos : Vector2) :
	var ret : Vector2
	ret.x = int(pos.x / camera.zoom.x) - (int(pos.x / camera.zoom.x) % GRID_CELL_SIZE) + int(GRID_CELL_SIZE / 2)
	ret.y = int(pos.y / camera.zoom.y) - (int(pos.y / camera.zoom.y) % GRID_CELL_SIZE) + int(GRID_CELL_SIZE / 2)
	return ret
	
