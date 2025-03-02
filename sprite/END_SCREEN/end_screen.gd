extends Node2D

@onready var page_1: Sprite2D = $Camera2D/Page_1
@onready var page_2: Sprite2D = $Camera2D/Page_2
@onready var texts: Node2D = $Camera2D/Page_2/texts

var scene_progression = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scene_progression == 0:
		page_1.visible = true
		page_2.visible = false
		texts.visible = true
		$Camera2D/Page_2/texts/Why.visible = false
		$"Camera2D/Page_2/texts/we came in peace".visible = false
		$"Camera2D/Page_2/texts/you murdered".visible = false
		$"Camera2D/Page_2/texts/my friends".visible = false
	elif  scene_progression == 1:
		page_1.visible = false
		page_2.visible = true
		texts.visible = true
		$Camera2D/Page_2/texts/Why.visible = true
		
		
	elif scene_progression == 2:
		$Camera2D/Page_2/texts/Why.visible = false
		$"Camera2D/Page_2/texts/we came in peace".visible = true
		
	elif scene_progression == 3:
		$"Camera2D/Page_2/texts/we came in peace".visible = false
		$"Camera2D/Page_2/texts/you murdered".visible = true
		
	elif scene_progression == 4:
		$"Camera2D/Page_2/texts/you murdered".visible = false
		$"Camera2D/Page_2/texts/my friends".visible = true
		
	elif scene_progression == 5:
		pass
		
	if Input.is_action_just_pressed("space"):
		scene_progression += 1
		
	
