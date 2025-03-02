extends TextureButton
@onready var world = get_node("/root/Main/World/")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pressed():
	world.buy_object(self.name)
	pass # Replace with function body.
