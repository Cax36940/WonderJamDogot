class_name Roi extends GridObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RoiIdle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass




func _on_area_2d_area_entered(area: Area2D) -> void:
	print ("roi mort")
	var scene = preload("res://sprite/END_SCREEN/End_screen.tscn")
	var instance
	if GlobalNode.pacifiste == true:
		scene = preload("res://sprite/END_SCREEN/good end.tscn")
		
		instance = scene.instantiate()
	else:
		scene = preload("res://sprite/END_SCREEN/End_screen.tscn")
		instance = scene.instantiate()
	$"/root/Main/World".queue_free()
	$"/root/Main".add_child(instance)
