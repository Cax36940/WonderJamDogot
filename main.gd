extends Node2D

@onready var start_menu: StartMenu = $StartMenu

@onready var world: Node2D = $World

var pause_menu = preload('res://menu/pause_menu/pause_menu.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	world.visible = false;
	get_tree().paused = true;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_menu_tree_exited() -> void:
	world.visible = true;
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			pause_game();
			

func pause_game() -> void:
	print("ESCAPE");
	var pause_menu_instance = pause_menu.instantiate();
	pause_menu_instance.tree_exited.connect(_on_pause_menu_tree_exited);
	add_child(pause_menu_instance);
	world.visible = false;
	

func _on_pause_menu_tree_exited() -> void:
	world.visible = true;
