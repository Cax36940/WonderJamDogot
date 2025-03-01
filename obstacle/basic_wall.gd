extends GridObject
#modificateur
var modif_vie : float =1
var modif_vie_voulu: bool = true 
var modif_cout : float = 1
var modif_cout_voulu: bool = false
var modif_poid : float =1 
var modif_poid_voulu: bool = false 
var modif_degat : float = 1
var modif_degat_voulu: bool = false 
var temps_modif: float =1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func lvl_up():
	niveau_actuelle+=1
	if modif_vie_voulu:
		temps_modif = modif_vie-niveau_actuelle*0.01
		if temps_modif<1.05 :
			vie = vie*1.05
		else:
			vie * temps_modif
	if modif_degat_voulu:
		temps_modif = modif_degat-niveau_actuelle*0.01
		if temps_modif<1.05:
			vie = vie*1.05
		else:
			vie * temps_modif
	if modif_cout_voulu:
		temps_modif = modif_cout-niveau_actuelle*0.01
		if temps_modif<1.05:
			vie = vie*1.05
		else:
			vie * temps_modif
	if modif_poid_voulu:
		temps_modif = modif_poid-niveau_actuelle*0.01
		if temps_modif<1.05:
			vie = vie*1.05
		else:
			vie * temps_modif
	
	

	
