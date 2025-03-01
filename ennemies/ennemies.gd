extends Node2D

var velocity = Vector2.ZERO
var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var parent: Node2D = get_parent()
	velocity = parent.global_position - global_position
	velocity = velocity.normalized() * speed
	global_position += velocity * delta
	if (parent.global_position - global_position).length() < 0.1 :
		queue_free()
		
func setup1():
	speed = 50
	modulate = Color(1,0,0)
	
func setup2():
	speed = 100
	modulate = Color(0,0,1)
