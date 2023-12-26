@tool
extends ACommand
class_name songgvisualAddFileProcessCommand

var data:BlackboardData

#初始化
func _init(_data:BlackboardData):
	data = _data

func start():
	addFileProcess()
	exec_finshed()

#添加流程
func addFileProcess():
	var area       = data.get_data("fileArea")
	var nowProcess = data.get_data("nowProcess")
	
	#创建物体
	var hbox = HBoxContainer.new()
	var btn  = Button.new()
	
	#初始化
	hbox.add_theme_constant_override("separation",0)
	
	#初始化按钮
	btn.text           = nowProcess.text
	btn.focus_mode     = Control.FOCUS_NONE
	btn.toggle_mode    = true
	btn.button_group   = data.get_data("fileBG")
	btn.button_pressed = true
	
	#添加至场景
	hbox.add_child(btn)
	area.add_child(hbox)
	
	data.get_data("scene").set_now_file_close(btn)
