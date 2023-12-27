@tool
extends ACommand
class_name songgvisualScanProcessCommand

var data:BlackboardData

#初始化
func _init(_data:BlackboardData):
	data = _data

func start():
	#清空流程区域
	var area = data.get_data("processArea")
	for item in area.get_children():
		area.remove_child(item)
	
	var dir   = DirAccess.open("res://scripts/process/")
	if dir  == null: return
	var files = dir.get_files()
	for i in range(files.size()):
		var file_name = files[i]
		file_name = file_name.trim_suffix(".gd")
		songgvisualAddProcessCommand.new(data,file_name).start()
	exec_finshed()
