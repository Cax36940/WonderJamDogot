extends Node

# Quantite de coins de depart
var coin_total : int = 1000000000
var coin_total_float : float = coin_total
var increase_factor : float = 1.01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func add_money_value(value):
	coin_total_float += value
	coin_total = int(coin_total_float)

func add_money(increase_value:float):
	coin_total_float += increase_value
	coin_total = int(coin_total_float)
	increase_value *= increase_factor

func remove_coin(value):
	coin_total_float -= value
	coin_total = int(coin_total_float)
