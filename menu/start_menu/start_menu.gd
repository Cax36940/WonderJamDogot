class_name StartMenu extends Control

@onready var btn_start: TextureButton = $CanvasLayer/VBoxContainer/btn_start
@onready var btn_quit: TextureButton = $CanvasLayer/VBoxContainer/btn_quit

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED;
	btn_start.pressed.connect(_on_start_pressed);
	btn_quit.pressed.connect(_on_quit_pressed);
	pass

func _on_start_pressed() -> void:
	print("START LEVEL");
	get_tree().paused = false;
	queue_free();
	
func _on_quit_pressed() -> void:
	print("QUIT");
	get_tree().quit();
