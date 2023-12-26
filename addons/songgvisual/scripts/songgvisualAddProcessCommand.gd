@tool
extends ACommand
class_name songgvisualAddProcessCommand

var data:BlackboardData
var process_name = "newProcess"

#初始化
func _init(_data:BlackboardData,_process_name=""):
	data = _data
	if _process_name != "":
		process_name = _process_name

func start():
	addProcess()
	exec_finshed()

#添加流程
func addProcess():
	#获取信息
	var area = data.get_data("processArea")
	
	#创建物体
	var marg = MarginContainer.new()
	var btn  = Button.new()
	
	#初始化
	marg.add_theme_constant_override("margin_left",5)
	marg.add_theme_constant_override("margin_right",5)
	marg.add_theme_constant_override("margin_top",1)
	marg.add_theme_constant_override("margin_bottom",1)
	
	#初始化按钮
	btn.text           = process_name
	btn.focus_mode     = Control.FOCUS_NONE
	btn.toggle_mode    = true
	btn.button_group   = data.get_data("processBG")
	btn.button_pressed = true
	
	#添加至场景
	marg.add_child(btn)
	area.add_child(marg)
	
