extends Node2D

const ENNEMY_SPAWN_TIME = 0.5
var timer = ENNEMY_SPAWN_TIME
var scene = preload("res://ennemies/ennemies.tscn")
var spawn_rate : float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if timer < 0 :
		var rand_value = randf()
		if (rand_value < spawn_rate):
			spawn()
		else :
			print("NOT SPAWNING")
		timer = ENNEMY_SPAWN_TIME
		spawn_rate = min(spawn_rate + 0.1 * delta,1)
	
	

func spawn():
	var instance = scene.instantiate()
	const radius = 600
	instance.scale *= 0.2
	var random_value = randi() % 4
	match random_value:
		0:
			instance.position = Vector2(randf_range(-radius,radius),-radius)
		1:
			instance.position = Vector2(radius,randf_range(-radius,radius))
		2:
			instance.position = Vector2(randf_range(-radius,radius),radius)
		3: 
			instance.position = Vector2(-radius,randf_range(-radius,radius))
	if (spawn_rate <= 0.3):
		instance.setup(0)
	elif (spawn_rate <= 0.5):
		instance.setup(randi()%2)
	elif (spawn_rate <= 0.7):
		instance.setup(randi()%3)
	else:
		instance.setup(randi()%4)
		
	add_child(instance)
	
