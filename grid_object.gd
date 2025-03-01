extends Node2D
class_name GridObject

var width : int = 1
var height : int = 1
var vie : float =1
var cout : float = 1
var poid : float =1 
var degat : float = 1
var niveau_actuelle : int = 1 


func _init(new_width := 1, new_height := 1):
	width = new_width
	height = new_height

func play():
	print("aaa")
func subir_degat(degatsubi):
	vie -=degatsubi
	if vie<=0 :
		pass

	


	
	
	
