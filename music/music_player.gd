extends Node2D


var kick_list  : Array[int] = [1,0,0,0,  1,0,0,0,  1,0,0,0,  1,0,0,0,  1,0,0,0,  1,0,0,0,  1,0,0,0,  1,0,0,0]
var bass1_list : Array[int] = [1,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0,  1,0,0,0,  0,0,0,0,  0,0,0,0,  1,0,0,0]
var bass2_list : Array[int] = [0,0,0,0,  0,0,0,0,  1,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0]
var hihat_list : Array[int] = [1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1]

var current_bar = 0

@onready var grid_object_container : Node2D = $"../GridObjectContainer"

const BAR_PER_SEC : int = 32
const FULL_BAR_LENGTH : float = 1.75
const BAR_LENGTH : float = FULL_BAR_LENGTH / 16
var timer = BAR_LENGTH
# Called when the node enters the scene tree for the first time.
func _ready():
	$Kick.volume_db = -20
	$Bass1.volume_db = -20
	$Bass2.volume_db = -20
	$Hihat.volume_db = -20
	print(BAR_LENGTH)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	if timer < 0:
		play_bar()
		timer += BAR_LENGTH
	pass

func play_bar():
	current_bar += 1
	if current_bar == BAR_PER_SEC:
		current_bar = 0
	kick()
	bass1()
	bass2()
	hihat()
	

func kick():
	var index = current_bar % kick_list.size()
	if kick_list[index] == 1:
		var db = 0
		for child in grid_object_container.get_children():
			if child is TowerCanon :
				if child.shoot() :
					db += 1
		if db == 0:
			$Kick.volume_db = -20
		else :
			$Kick.volume_db = min(db, 20)
			$Kick.play()

func bass1():
	var index = current_bar % bass1_list.size()
	if bass1_list[index] == 1:
		var db = 0
		for child in grid_object_container.get_children():
			if child is TowerDoubleCanon :
				if child.shoot() :
					db += 1
		if db == 0:
			$Bass1.volume_db = -20
		else :
			$Bass1.volume_db = min(db, 20)
			$Bass1.play()
		
func bass2():
	var index = current_bar % bass2_list.size()
	if bass2_list[index] == 1:
		var db = 0
		for child in grid_object_container.get_children():
			if child is TowerFire :
				if child.shoot() :
					db += 1
		if db == 0:
			$Bass2.volume_db = -20
		else :
			$Bass2.volume_db = min(db, 20)
			$Bass2.play()

func hihat():
	var index = current_bar % hihat_list.size()
	if hihat_list[index] == 1:
		var db = 0
		for child in grid_object_container.get_children():
			if child is TowerPlasma :
				if child.shoot() :
					db += 1
		if db == 0:
			$Hihat.volume_db = -20
		else :
			$Hihat.volume_db = min(db, 20)
			$Hihat.play()
