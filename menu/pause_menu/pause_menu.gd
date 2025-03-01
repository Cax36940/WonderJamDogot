class_name PauseMenu extends Control

@onready var btn_resume: Button = $CanvasLayer/VBoxContainer/btn_resume
@onready var btn_quit: Button = $CanvasLayer/VBoxContainer/btn_quit

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED;
	btn_resume.pressed.connect(_on_resume_pressed);
	btn_quit.pressed.connect(_on_quit_pressed);
	get_tree().paused = true;
	

func _on_resume_pressed() -> void:
	print("RESUME");
	get_tree().paused = false;
	queue_free();
	pass

func _on_quit_pressed() -> void:
	print("QUIT");
	get_tree().quit();
	pass
