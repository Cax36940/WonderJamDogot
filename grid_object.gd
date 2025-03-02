extends Node2D
class_name GridObject

var width 	: int 	= 1
var height 	: int 	= 1
var health 	: float = 1.
var cost 	: float = 1. 
var path_weight : float = 1.
var attack 	: float = 1.
var current_level : int = 1

func play():
	print("aaa")
	
func take_damage(damage : float):
	health -= damage
	if health <= 0 :
		pass

func lvl_up() -> void :
	lvl_up_health()
	lvl_up_cost()
	lvl_up_weight()
	lvl_up_attack()
	lvl_up_range()


# Functions to override by children class
func lvl_up_health() -> void :
	pass

func lvl_up_cost() -> void :
	pass

func lvl_up_weight() -> void :
	pass

func lvl_up_attack() -> void :
	pass
func lvl_up_range() -> void:
	pass 
