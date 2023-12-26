@tool
extends ACommand
class_name songgvisualClearFileAreaCommand

var data:BlackboardData

#初始化
func _init(_data:BlackboardData):
	data = _data

func start():
	#删除文件界面
	var fileArea = data.get_data("fileArea")
	for item in fileArea.get_children():
		fileArea.remove_child(item)
	#删除显示详情界面
	var area = data.get_data("contentPanel")
	for item in area.get_children():
		area.remove_child(item)
	#删除显示命令列表
	var commands = data.get_data("commandsPanel")
	for item in commands.get_children():
		commands.remove_child(item)
	exec_finshed()
