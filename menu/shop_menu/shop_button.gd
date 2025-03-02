extends TextureButton

@onready var world = get_node("/root/Main/World/")

@onready var label = $Label.text

var cost: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalNode.coin_total < str_to_int(label) :
		self.disabled = true
	else:
		self.disabled = false
	pass

func _on_pressed() -> void:
	world.buy_object(self.name)
	
func str_to_int(string):
	var regex = RegEx.new()
	regex.compile("\\d+")
	var all_numbers_found = regex.search_all(string)
	for number in all_numbers_found:
		var number_found = int(number.get_string())
		return(number_found)
