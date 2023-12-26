@tool
extends ACommand
class_name songgvisualLoadConfigCommand

var data:BlackboardData

#初始化
func _init(_data:BlackboardData):
	data = _data

func start():
	var f    = FileAccess.open("res://addons/songgvisual/config/core.json",FileAccess.READ)
	var core = JSON.parse_string(f.get_as_text())
	exec_finshed()
