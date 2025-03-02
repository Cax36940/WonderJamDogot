extends Node2D

const ENNEMY_SPAWN_TIME = 0.3
var timer = ENNEMY_SPAWN_TIME
var scene = preload("res://ennemies/ennemies.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn()
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
	var random_ennemy: int = randi_range(0,3)
	if random_ennemy == 0 :
		instance.setup1()
	elif random_ennemy == 1 :
		instance.setup2()
	elif random_ennemy == 2:
		instance.setup3()
	else:
		instance.setup4()
	add_child(instance)
	
