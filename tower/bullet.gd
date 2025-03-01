extends Node2D
var vitesse =400
var direction = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position+= direction*delta*vitesse
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	body.queue_free()
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	# Replace with function body.
	area.get_parent().queue_free()
	queue_free()
