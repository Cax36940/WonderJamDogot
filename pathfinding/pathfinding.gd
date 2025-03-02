class_name PathFinding extends Node2D

@onready var grid_cell_size: int = $"/root/Main/World".GRID_CELL_SIZE
@onready var spawner = $"/root/Main/World/Spawner"
@onready var object_container = $"/root/Main/World/GridObjectContainer"
@onready var grid: Grid

var DebugArrowScene = preload("res://pathfinding/debugarrow.tscn")

func _ready() -> void:
	grid = Grid.new(Vector2(41,41))
	print(grid.center)
	grid.init_grid()
	grid.update_directions()
	for y in range(grid.grid_size.y):
		for x in range(grid.grid_size.x):
			var arrow:Node2D = DebugArrowScene.instantiate()
			arrow.position = 16 * Vector2(x,y) + Vector2(8,8)
			arrow.look_at(16 * Vector2(x + grid.grid[y][x].direction.x,y + grid.grid[y][x].direction.y))
			add_child(arrow)

func _process(_delta) -> void:
	for child in spawner.get_children():
		var curr_cell = grid.grid[int(child.global_position.y / 16)][int(child.global_position.x / 16)]
		var old_velocity = child.velocity
		child.velocity = curr_cell.direction * 16 * child.speed
		
		if old_velocity != child.velocity:
			print(int(child.global_position.y / 16)," ",int(child.global_position.x / 16))
			print("NNNNNo")
			print(curr_cell.direction)
		#print(child.velocity)
		if curr_cell == grid.grid[grid.center.y][grid.center.x]:
			child.queue_free()
			
func update_weights() -> void:
	var grid_objects = object_container.get_children()
	for object:GridObject in grid_objects:
		var pos = object.global_position
		var pos_grid = Vector2(int(pos.x/16),int(pos.y/16))
		for x in range(pos_grid.x+object.width):
			for y in range(pos_grid.y+object.height):
				grid.update_weight(x,y,object.path_weight)
		
