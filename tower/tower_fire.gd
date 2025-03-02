extends GridObject 
class_name TowerFire
@onready var detection_area: Area2D = $DetectionArea

var bullet_ref = preload("res://tower/fire_bullet.tscn")
var health_modif : 	float = 1.
var cost_modif : 	float = 2.
var weight_modif : 	float = 1.
var attack_modif : 	float = 1.
var range_modif : 	float = 1.
var can_shoot: bool = false
var timer =1
var vitesseDeTire :float =1
# Called when the node enters the scene tree for the first time.
var liste_ennemi = []

var place_cost : int = 1000000
var tower_range : int = 200
var hp : int = 200

func _ready() -> void:
	width = 2
	height = 2
	attack = 50
	detection_area.get_child(0).shape.radius = tower_range

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	liste_ennemi = detection_area.get_overlapping_areas()
	if !liste_ennemi.is_empty():
		can_shoot = true
		
		$LanceFlammeDroit.look_at(liste_ennemi[0].global_position)
	else :
		can_shoot = false
	
func shoot() -> bool:
	if can_shoot :
		var vecteur = Vector2(1,0)
		vecteur= vecteur.rotated($LanceFlammeDroit.rotation)
		var instance = bullet_ref.instantiate()
		instance.position = $LanceFlammeDroit/BoutDeCanon.global_position - global_position
		instance.direction = vecteur #On peut modifier l'instance avant de l'ajouter
		instance.rotation = $LanceFlammeDroit.rotation
		instance.attack = attack
		add_child(instance)
		return true
	return false

func lvl_up_health() -> void :
	var tmp_modif : float = health_modif - current_level * 0.01
	if tmp_modif < 1.05 :
		health = health * 1.05
	else :
		health *= tmp_modif
	pass

func lvl_up_cost() -> void :
	$Anneau.modulate = Color.from_hsv(float((100 + 10 * current_level) % 360) / 360, 0.8, 0.8)
	var tmp_modif : float = cost_modif - current_level * 0.05
	if tmp_modif < 1.05 :
		cost = cost * 1.05
	else :
		cost *= tmp_modif
	pass

func lvl_up_weight() -> void :
	#var tmp_modif : float = weight_modif - current_level * 0.01
	#if tmp_modif < 1.05 :
	#	path_weight = path_weight * 1.05
	#else :
	#	path_weight *= tmp_modif
	pass

func lvl_up_attack() -> void :
	attack *= 1.1
	pass
func lvl_up_range() -> void :
	#var tmp_modif : float = range_modif - current_level * 0.01
	#if tmp_modif < 1.05 :
	#	range = range * 1.05
	#else :
	#	range *= tmp_modif
	pass
