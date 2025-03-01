class_name GridCell extends Resource

@export var weight : int
@export var direction : Vector2
@export var size : int = 10

func _init(w:int = 0, dir:Vector2 = Vector2(0,0)) -> void:
	weight = w
	direction = dir
