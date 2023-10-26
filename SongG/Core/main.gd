extends Node

func _init():
	Global.add_utility("file",GodotFileUtility.new())
	
func _ready():
	var file = Global.get_utility("file")
	file.save("res://aaa.txt","1234567")
