extends TextureButton

@onready var world = get_node("/root/Main/World/")

var cost: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.name == "iconCanon":
		cost = 100
	elif self.name == "iconDoubleCanon":
		cost = 10000
	elif self.name == "iconLanceFlamme":
		cost = 1000000
	elif self.name == "iconCanonPlasma":
		cost = 100000000
	elif self.name == "iconBarriere":
		cost = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalNode.coin_total < cost :
		self.disabled = true
	else:
		self.disabled = false
	pass

func _on_pressed() -> void:
	world.buy_object(self.name)
