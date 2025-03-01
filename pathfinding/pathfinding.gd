class_name PathFinding extends Node2D

@onready var grid_cell_size: int = $"/root/Main/World".GRID_CELL_SIZE
@onready var grid_size: Vector2 = $"/root/Main/World/GridSprite".grid_size
@onready var grid: Grid = Grid.new(Vector2(40,40))


func _ready() -> void:
	grid.init_grid()


func _process(_delta) -> void:
	grid.update_directions()
