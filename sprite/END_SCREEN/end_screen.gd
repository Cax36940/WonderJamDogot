extends Node2D

@onready var page_1: Sprite2D = $Camera2D/Page_1
@onready var page_2: Sprite2D = $Camera2D/Page_2
@onready var texts: Node2D = $Camera2D/Page_2/texts
@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer


var scene_progression = 0

var timer_start:bool = false
var timer :float = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Vérifie si une musique est assignée et active la boucle
	if music_player.stream:
		music_player.stream.loop = true  # Active la boucle
		music_player.play()

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
		timer_start= true
		
	elif scene_progression == 5:
		pass
		
	
	if Input.is_action_just_pressed("space") && scene_progression <5:
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
		
	
