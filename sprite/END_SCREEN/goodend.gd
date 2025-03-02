extends Node2D

@onready var page_1: Sprite2D = $Camera2D/Page_1
@onready var page_2: Sprite2D = $Camera2D/Page_2


var scene_progression = 0

var timer_start:bool = false
var timer :float = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scene_progression == 0:
		page_1.visible = true
		page_2.visible = false
		
		
	elif  scene_progression == 1:
		page_1.visible = false
		page_2.visible = true
		timer_start= true
	
	if Input.is_action_just_pressed("space") && scene_progression <2:
		scene_progression += 1
		
	if timer_start:
		timer -= delta
		if timer <=0:
			get_tree().reload_current_scene()
			#var scene = preload()
			#var instance
			#instance = scene.instantiate()
			#instance = scene.instantiate()
			#$"/root/Main/End_screnn".queue_free()
			#$"/root/Main".add_child(instance)
		
	
