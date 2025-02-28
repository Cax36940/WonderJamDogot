extends Node2D
class_name GridObject

var width : int = 1
var height : int = 1

func _init(new_width := 1, new_height := 1):
	width = new_width
	height = new_height

func play():
	print("aaa")
