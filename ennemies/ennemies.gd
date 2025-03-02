extends Node2D

var velocity = Vector2.ZERO
var speed = 50

var life : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var parent: Node2D = get_parent()
	#velocity = parent.global_position - global_position
	#velocity = velocity.normalized() * speed
	global_position += velocity * delta
	if velocity.x >= 0:
		$Icon.flip_h = true
	else: $Icon.flip_h = false
	#if (parent.global_position - global_position).length() < 0.1 :
		#queue_free()

func setup(n:int):
	match n:
		0:
			speed = 2
			$Icon.play("Crawler")
		1:
			speed = 4
			$Icon.play("Ball")
		2:
			speed = 0.5
			$Icon.play("Mecha")
		3:
			speed = 7
			$Icon.play("Flyer")
		_:
			speed = 2
			$Icon.play("Crawler")

func take_damage(damage : float):
	life -= damage
	if life < 0 :
		GlobalNode.add_money()
		queue_free()
