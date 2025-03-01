class_name BaseTower extends GridObject

@onready var detection_area: Area2D = $DetectionArea
@onready var body: StaticBody2D = $Body
@onready var detection_shape: CollisionShape2D = $DetectionArea/CollisionShape2D

var range : int = 100
var damage : int = 1
var cost : int = 50
var hp : int = 200

func _ready() -> void:
	detection_shape.shape.radius = range
	detection_area.area_entered.connect(_on_detected)
	detection_area.body_exited.connect(_on_exited)
	

func _on_detected(area) -> void:
	print(area.get_parent())
	print("DETECTED")
	
func _on_exited(area) -> void:
	print(area.get_parent())
	print("EXITED")
	
func _process(delta: float) -> void:
	pass
	#print(detection_area.monitoring)
