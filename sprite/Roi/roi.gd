class_name Roi extends GridObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RoiIdle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass




func _on_area_2d_area_entered(area: Area2D) -> void:
	print ("roi mort")
