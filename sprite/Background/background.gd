extends Node

const IMAGE_SIZE := 2336
const TILE_SIZE := 16
const GRID_SIZE := int(float(IMAGE_SIZE) / float(TILE_SIZE))
const SEED := 1234  # Change for different noise patterns

@onready var sprite : Sprite2D = $Sprite

var noise := FastNoiseLite.new()
var grass_tile_textures: Array[Image] = []
var purple_tile_textures: Array[Image] = []

func _ready():
	# Initialize Perlin noise
	noise.seed = randi_range(0, 65255)
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 0.15  # Adjust for variation
	
	# Load tile images
	for i in range(7):
		var tex = load("res://sprite/Background/grass%d.png" % i) as Texture2D
		grass_tile_textures.append(tex.get_image())
		
		tex = load("res://sprite/Background/purple%d.png" % i) as Texture2D
		purple_tile_textures.append(tex.get_image())

	
	# Create big image
	var big_image := Image.create(IMAGE_SIZE, IMAGE_SIZE, false, Image.FORMAT_RGB8)
	for y in range(GRID_SIZE):
		for x in range(GRID_SIZE):
			# Get tile and blit to big image
			var tile : Image
			if max(abs(x - 75), abs(y - 75)) > 20 :
				var noise_val := noise.get_noise_2d(x, y)
				noise_val = pow(abs(noise_val), 1.4) * sign(noise_val)
				var tile_index := int((noise_val + 1) / 2 * 7) % 7  # Normalize to 0-6
				tile = purple_tile_textures[tile_index]
			else :
				var noise_val := noise.get_noise_2d(x + 1000, y + 1000)
				noise_val = pow(abs(noise_val), 1.4) * sign(noise_val)
				var tile_index := int((noise_val + 1) / 2 * 7) % 7  # Normalize to 0-6
				tile = grass_tile_textures[tile_index]
			big_image.blit_rect(tile, Rect2i(0, 0, TILE_SIZE, TILE_SIZE), Vector2i(x * TILE_SIZE, y * TILE_SIZE))
	
	# Save image
	#big_image.save_png("res://output.png")
	sprite.texture = ImageTexture.create_from_image(big_image)
	#print(sprite.texture.get_size())
