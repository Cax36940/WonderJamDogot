extends Node2D

@onready var camera : Camera2D = $Camera
@onready var mouse_object_container : Node2D = $MouseObjectContainer
@onready var grid_object_container : Node2D = $GridObjectContainer

@onready var pathfinding : Node2D = $Pathfinding

var basic_wall_scene = preload("res://obstacle/basic_wall.tscn")
var spikes_scene = preload("res://obstacle/spikes.tscn")

var canon_tower_scene = preload("res://tower/tower_canon.tscn")
var canon_double_tower_scene = preload("res://tower/tower_canonDouble.tscn")
var fire_tower_scene = preload("res://tower/tower_fire.tscn")
var plasma_tower_scene = preload("res://tower/tower_plasma.tscn")

var delete_scene = preload("res://menu/bonus_menu/icon_delete.tscn")
var upgrade_scene = preload("res://menu/bonus_menu/icon_upgrade.tscn")

var obstacle_name_list : Array[String] = ["iconCanon", "iconDoubleCanon", "iconLanceFlame", "iconCanonPlasma", "DeleteButton", "UpgradeButton"]
var obstacle_scene_list = [canon_tower_scene, canon_double_tower_scene, fire_tower_scene, plasma_tower_scene, delete_scene, upgrade_scene]

const GRID_CELL_SIZE : int = 16
const GRID_HALF_CELL_SIZE : int = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.enabled = true
	#var instance : GridObject = canon_tower_scene.instantiate()
	#instance.modulate.a = 0.5
	#mouse_object_container.add_child(instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _input(event):
	if event is InputEventMouseMotion:
		if mouse_object_container.get_child_count() > 0:
			var object = mouse_object_container.get_child(0)
			if object is GridObject :
				object.position = align_on_grid(get_global_mouse_position(), object.width, object.height)
				mouse_object_container.visible = is_pos_free(get_global_mouse_position(), object.width, object.height)
				mouse_object_container.z_index = int(object.position.y / 16)
				if Input.is_action_pressed("mouse_click"):
					spawn_object_at_pos(get_global_mouse_position())
			else :
				object.position = get_global_mouse_position()
				mouse_object_container.visible = true
				#mouse_object_container.visible = !is_pos_free(get_global_mouse_position(), 1, 1)
				mouse_object_container.z_index = int(object.position.y / 16) + 1
				if Input.is_action_pressed("mouse_click"):
					if object is DeleteObject :
						delete_at_pos(get_global_mouse_position())
					if object is UpgradeObject :
						upgrade_at_pos(get_global_mouse_position())
				
				
	if Input.is_action_just_pressed("mouse_click"):
		if mouse_object_container.get_child_count() > 0:
			var object = mouse_object_container.get_child(0)
			if object is GridObject :
				spawn_object_at_pos(get_global_mouse_position())
			else :
				if object is DeleteObject :
					delete_at_pos(get_global_mouse_position())
				if object is UpgradeObject :
					upgrade_at_pos(get_global_mouse_position())
	
	if Input.is_action_just_pressed("mouse_cancel"):
		if mouse_object_container.get_child_count() > 0:
			mouse_object_container.get_child(0).queue_free()
			
			
func align_on_grid(pos : Vector2, width : int, height : int) :
	var ret : Vector2
	if pos.x < 0:
		pos.x -= GRID_CELL_SIZE
	
	if pos.y < 0:
		pos.y -= GRID_CELL_SIZE
		
	ret.x = int(pos.x) - (int(pos.x) % GRID_CELL_SIZE) + GRID_HALF_CELL_SIZE * width
	ret.y = int(pos.y) - (int(pos.y) % GRID_CELL_SIZE) + GRID_HALF_CELL_SIZE * height
	return ret

func is_pos_free(pos : Vector2, width : int, height : int):
	
	var aligned_pos : Vector2 = align_on_grid(pos, width, height)
	if pos.x < 0 or pos.y < 0:
		return false
	
	if int(aligned_pos.x / 16) < 0 or int(aligned_pos.x / 16) > 42 - width or int(aligned_pos.y / 16) < 0 or int(aligned_pos.y / 16) > 42 - height:
		return false
	
	
	var max_aligned_pos : Vector2 = Vector2.ZERO
	max_aligned_pos.x = aligned_pos.x + width * GRID_CELL_SIZE
	max_aligned_pos.y = aligned_pos.y + width * GRID_CELL_SIZE
	
	for child : GridObject in grid_object_container.get_children():
		var min_x : float = child.position.x #- child.width * GRID_HALF_CELL_SIZE 
		var max_x : float = child.position.x  + (child.width) * GRID_CELL_SIZE
		var min_y : float = child.position.y #- child.height * GRID_HALF_CELL_SIZE
		var max_y : float = child.position.y  + (child.height ) * GRID_CELL_SIZE
		
		var min_pos : Vector2 = Vector2(min_x, min_y)
		var max_pos : Vector2 = Vector2(max_x, max_y)

		if overlap(aligned_pos, max_aligned_pos, min_pos, max_pos):
			return false
	return true	

func spawn_object_at_pos(pos : Vector2):
	if mouse_object_container.get_child_count() > 0 :
		
		var object : GridObject = mouse_object_container.get_child(0)
		if is_pos_free(pos, object.width, object.height):
			var instance : GridObject = object.duplicate()
			
			#Si on a assez d'argent, effectue le code, et reduit l'argent
			if GlobalNode.remove_coin(instance.place_cost):
				#print("BOUGHT   " + str(instance))
				instance.modulate.a = 1.0
				instance.z_index = int(instance.position.y / 16)
				grid_object_container.add_child(instance)
				pathfinding.update_weights()

func delete_at_pos(pos : Vector2):
	if mouse_object_container.get_child_count() > 0 :
		var object = mouse_object_container.get_child(0)
		if object is DeleteObject:
			for child : GridObject in grid_object_container.get_children():
				if child.position.x - 16 < pos.x and pos.x < child.position.x + 16 and child.position.y - 16 < pos.y and pos.y < child.position.y + 16:
					if child is not Roi:
						GlobalNode.add_money_value(child.place_cost * 0.75)
						child.queue_free()

func upgrade_at_pos(pos : Vector2):

	if mouse_object_container.get_child_count() > 0 :
		var object = mouse_object_container.get_child(0)
		if object is UpgradeObject:
			for child : GridObject in grid_object_container.get_children():
				if child.position.x - 16 < pos.x and pos.x < child.position.x + 16 and child.position.y - 16 < pos.y and pos.y < child.position.y + 16:
					if child is not Roi:
						child.lvl_up()

func overlap(min_pos1 : Vector2, max_pos1 : Vector2, min_pos2 : Vector2, max_pos2 : Vector2):
	if min_pos1.x >= max_pos2.x or min_pos2.x >= max_pos1.x :
		return false
		
	if min_pos1.y >= max_pos2.y or min_pos2.y >= max_pos1.y :
		return false
	
	return true
	
func clear_mouse_object():
	for child in mouse_object_container.get_children():
		child.queue_free()
	
func buy_object(string : String):
	#print(string)
	clear_mouse_object()
	for i in range(0, obstacle_name_list.size()):
		if string == obstacle_name_list[i]:
			clear_mouse_object()
			var instance = obstacle_scene_list[i].instantiate()
			instance.modulate.a = 0.5
			mouse_object_container.add_child(instance)
