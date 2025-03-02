class_name StartMenu extends Control

@onready var btn_start: TextureButton = $CanvasLayer/VBoxContainer/btn_start
@onready var btn_quit: TextureButton = $CanvasLayer/VBoxContainer/btn_quit
@onready var music_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED;
	btn_start.pressed.connect(_on_start_pressed);
	btn_quit.pressed.connect(_on_quit_pressed);
	
	# Jouer la musique si un fichier est assigné
	if music_player.stream:
		music_player.play()

func _on_start_pressed() -> void:
	print("START LEVEL")
	get_tree().paused = false
	music_player.stop()  # Arrêter la musique quand on quitte le menu
	queue_free()

func _on_quit_pressed() -> void:
	print("QUIT")
	get_tree().quit()
