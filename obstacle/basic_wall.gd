extends GridObject
# modifiers
var health_modif : 	float = 1.
var cost_modif : 	float = 1.
var weight_modif : 	float = 1.
var attack_modif : 	float = 1.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func lvl_up_health() -> void :
	var tmp_modif : float = health_modif - current_level * 0.01
	if tmp_modif < 1.05 :
		health = health * 1.05
	else :
		health *= tmp_modif
	pass

func lvl_up_cost() -> void :
	#var tmp_modif : float = cost_modif - current_level * 0.01
	#if tmp_modif < 1.05 :
	#	cost = cost * 1.05
	#else :
	#	cost *= tmp_modif
	pass

func lvl_up_weight() -> void :
	#var tmp_modif : float = weight_modif - current_level * 0.01
	#if tmp_modif < 1.05 :
	#	path_weight = path_weight * 1.05
	#else :
	#	path_weight *= tmp_modif
	pass

func lvl_up_attack() -> void :
	#var tmp_modif : float = attack_modif - current_level * 0.01
	#if tmp_modif < 1.05 :
	#	attack = attack * 1.05
	#else :
	#	attack *= tmp_modif
	pass
