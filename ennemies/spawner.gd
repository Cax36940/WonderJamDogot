extends Node2D

const ENNEMY_SPAWN_TIME = 1
var timer = ENNEMY_SPAWN_TIME
var scene = preload("res://ennemies/ennemies.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if timer < 0 :
		timer = ENNEMY_SPAWN_TIME
		spawn()
	

func spawn():
	var instance = scene.instantiate()
	var random_value = randf_range(0, 2*PI)
	instance.position.x = 200 * cos(random_value)
	instance.position.y = 200 * sin(random_value)
	instance.scale *= 0.2
	if randi_range(0,1) == 0:
		instance.setup1()
	else:
		instance.setup2()
	add_child(instance)
	
