class_name Grid extends Node

var grid_size : Vector2
var grid = []
var center:Vector2



func _init(size: Vector2 = Vector2(40,40)) -> void:
	grid_size = size
	center = Vector2(int(grid_size.x / 2),int(grid_size.y / 2))
	
func _ready() -> void:
	init_grid()
	
func init_grid() -> void:
	for y in range(grid_size.y):
		var row = []
		for x in range(grid_size.x):
			var g = GridCell.new(distance_to_center(x,y))
			row.append(g)
		grid.append(row)
		pass

func update_directions() -> void:
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			grid[y][x].direction = compute_best_neighbour(Vector2(x,y))
			
		
func distance_to_center(x:int,y:int):
	return abs(x - center.x) + abs(y-center.y)

func update_weight(x:int,y:int,weight:float):
	if y < 41 and x < 41 :
		grid[y][x].weight = distance_to_center(x,y) + weight
	
func compute_best_neighbour(coords:Vector2) -> Vector2:
	
	var best_score = INF
	var best_neighbour_dir = Vector2(0,0)
	var directions = [Vector2(-1,-1),Vector2(-1,0),Vector2(-1,1),Vector2(0,-1),Vector2(0,1),
					  Vector2(1,-1),Vector2(1,0),Vector2(1,1)]
	for direction in directions:
		var curr_neighbour_pos = coords + direction
		if is_in_grid(curr_neighbour_pos):
			if grid[curr_neighbour_pos.y][curr_neighbour_pos.x].weight < best_score:
				best_neighbour_dir = direction
				
				best_score = grid[curr_neighbour_pos.y][curr_neighbour_pos.x].weight
	return best_neighbour_dir

func is_in_grid(coords:Vector2):
	return 0 <= coords.x && coords.x < grid_size.x && 0 <= coords.y && coords.y < grid_size.y
