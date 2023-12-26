@tool
extends ACommand
class_name songgvisualInitDataCommand

var data:BlackboardData

#初始化
func _init(_data:BlackboardData):
	data = _data

func start():
	#设置按钮组
	data.set_data("processBG", ButtonGroup.new())
	data.set_data("fileBG"   , ButtonGroup.new())
	
	exec_finshed()
