class_name StartMenu extends Control

@onready var btn_start: TextureButton = $CanvasLayer/VBoxContainer/btn_start
@onready var btn_quit: TextureButton = $CanvasLayer/VBoxContainer/btn_quit

@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer


@onready var fondDecrant: TextureRect = $CanvasLayer/TextureRect

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED;
	btn_start.pressed.connect(_on_start_pressed);
	btn_quit.pressed.connect(_on_quit_pressed);
	
	if music_player.stream:
		music_player.stream.loop = true  # Active la boucle
		music_player.play()

	if GlobalNode.pacifiste:
		fondDecrant.texture = preload("res://menu/Roi_Bannerr.png")
		
	else :
		fondDecrant.texture = preload("res://sprite/Bouton/main menu.png")
	pass


func _on_start_pressed() -> void:
	print("START LEVEL")
	get_tree().paused = false
	music_player.stop()  # Arrêter la musique quand on quitte le menu
	queue_free()

func _on_quit_pressed() -> void:
	print("QUIT")
	get_tree().quit()
