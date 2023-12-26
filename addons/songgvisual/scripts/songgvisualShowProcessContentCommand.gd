@tool
extends ACommand
class_name songgvisualShowProcessContentCommand

var data:BlackboardData          #黑板数据
var process_data:SongGCodeData   #代码数据
var cardStyle:StyleBoxFlat       #卡片样式
var cardChooseStyle:StyleBoxFlat #卡片样式
var commandBtnBG:ButtonGroup     #方法区域按钮组
var area                         #主面板区域
var commands                     #添加方法区域
var nowChooseFunc                #当前选择的方法
var infoArea                     #节点详情区域
var startArea                    #开始方法区域
var exitArea                     #开始方法区域
var filePath                     #文件路径

#初始化
func _init(_data:BlackboardData):
	data = _data
	process_data = data.get_data("nowProcessData")
	area = data.get_data("contentPanel")
	commands = data.get_data("commandsPanel")
	data.del_data("ShowProcessContent")
	data.set_data("ShowProcessContent",self)
	clear_content()
	clear_commands()
	card_style()
	commandBtnBG = ButtonGroup.new()
	filePath  = data.get_data("filePathBtn")
	filePath.text = process_data.get_file_path()

func start():
	##创建流程详细
	infoFunc()
	##流程开始方法
	startFunc()
	##流程退出方法
	exitFunc()
	#绑定命令菜单点击
	commandBtnBG.pressed.connect(Callable(self,"command_pressed"))

#创建详情方法
func infoFunc():
	infoArea      = card()
	var proName       = LineEdit.new()
	var dec           = LineEdit.new()
	#初始化数值
	proName.flat      = true
	dec.flat          = true
	proName.text      = process_data.process_name
	proName.alignment = HORIZONTAL_ALIGNMENT_CENTER
	dec.alignment     = HORIZONTAL_ALIGNMENT_CENTER
	if process_data.description.has("de_zh"):
		var de        = process_data.description["de_zh"]
		dec.text      = de
	infoArea.add_child(proName)
	infoArea.add_child(dec)
	#绑定事件
	proName.text_changed.connect(Callable(self,"process_name_change"))
	dec.text_changed.connect(Callable(self,"dec_change"))
	proName.text_submitted.connect(Callable(self,"unfocus_info"))
	dec.text_submitted.connect(Callable(self,"unfocus_info"))

#创建开始方法区域
func startFunc():
	##流程开始方法
	startArea = card()
	#开始方法提示
	var title = card_title("Func Start")
	startArea.add_child(title)
	#开始方法详情
	for item in process_data.start:
		append_Command(startArea,item)
	var titleCall = Callable(self,"create_commands_start")
	if !title.pressed.is_connected(titleCall):
		title.pressed.connect(titleCall)

#创建退出方法区域
func exitFunc():
	exitArea  = card()
	#退出方法提示
	var title = card_title("Func Exit")
	exitArea.add_child(title)
	#退出方法详情
	for item in process_data.exit:
		append_Command(exitArea,item)	
	#绑定按钮事件
	var titleCall = Callable(self,"create_commands_exit")
	if !title.pressed.is_connected(titleCall):
		title.pressed.connect(titleCall)

#创建方法按钮
func append_Command(area,text):
	var marg = margin_area()
	var command  = Button.new()
	command.text = text
	marg.add_child(command)
	area.add_child(marg)

#流程名称改变
func process_name_change(new_text):
	#同步流程列表
	var proArea   = data.get_data("processArea")
	for item in proArea.get_children():
		var f_btn = item.get_child(0)
		if f_btn.text == process_data.process_name:
			f_btn.text = new_text
	#同步文件列表
	var fileArea   = data.get_data("fileArea")
	for item in fileArea.get_children():
		var f_btn = item.get_child(0)
		if f_btn.text == process_data.process_name:
			f_btn.text = new_text
	process_data.process_name = new_text
	filePath.text = process_data.get_file_path()

#取消流程焦点
func unfocus_info(text=""):
	var pn = infoArea.get_child(0)
	var de = infoArea.get_child(1)
	pn.focus_mode = Control.FOCUS_NONE
	pn.focus_mode = Control.FOCUS_ALL
	de.focus_mode = Control.FOCUS_NONE
	de.focus_mode = Control.FOCUS_ALL

#备注
func dec_change(new_text):
	process_data.description["de_zh"] = new_text

#卡片样式
func card_style():
	cardStyle                            = StyleBoxFlat.new()
	cardStyle.bg_color                   = Color("566070")
	cardStyle.corner_detail              = 8
	cardStyle.corner_radius_top_left     = 8
	cardStyle.corner_radius_top_right    = 8
	cardStyle.corner_radius_bottom_left  = 8
	cardStyle.corner_radius_bottom_right = 8
	cardStyle.border_width_left          = 2
	cardStyle.border_width_top           = 2
	cardStyle.border_width_right         = 2
	cardStyle.border_width_bottom        = 2
	cardStyle.border_color               = Color("566070")
	
	cardChooseStyle                            = StyleBoxFlat.new()
	cardChooseStyle.bg_color                   = Color("1F6DB0")
	cardChooseStyle .corner_detail              = 8
	cardChooseStyle.corner_radius_top_left     = 8
	cardChooseStyle.corner_radius_top_right    = 8
	cardChooseStyle.corner_radius_bottom_left  = 8
	cardChooseStyle.corner_radius_bottom_right = 8
	cardChooseStyle.border_width_left          = 2
	cardChooseStyle.border_width_top           = 2
	cardChooseStyle.border_width_right         = 2
	cardChooseStyle.border_width_bottom        = 2
	cardChooseStyle.border_color               = Color("1F6DB0")

#创建卡片
func card()->VBoxContainer:
	var marg = MarginContainer.new()
	marg.add_theme_constant_override("margin_left",20)
	marg.add_theme_constant_override("margin_right",20)
	marg.add_theme_constant_override("margin_top",10)
	marg.add_theme_constant_override("margin_bottom",10)
	var panl = PanelContainer.new()
	panl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panl.size_flags_vertical   = Control.SIZE_EXPAND_FILL
	panl.add_theme_stylebox_override("panel",cardStyle)
	var pmar = MarginContainer.new()
	pmar.add_theme_constant_override("margin_bottom",10)
	var vbox = VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.size_flags_vertical   = Control.SIZE_EXPAND_FILL
	vbox.add_theme_constant_override("separation",3)
	pmar.add_child(vbox)
	panl.add_child(pmar)
	marg.add_child(panl)
	area.add_child(marg)
	return vbox

#卡片标题区域
func card_title(text)->Button:
	var btn        = Button.new()
	btn.text       = text
	btn.flat       = true
	btn.focus_mode = Control.FOCUS_NONE
	return btn

#区域
func margin_area()->MarginContainer:
	var marg = MarginContainer.new()
	marg.add_theme_constant_override("margin_left",10)
	marg.add_theme_constant_override("margin_right",10)
	return marg

#创建开始方法
func create_commands_start():
	nowChooseFunc = "Start"
	var s = startArea.get_parent().get_parent()
	var e = exitArea.get_parent().get_parent()
	s.add_theme_stylebox_override("panel",cardChooseStyle)
	e.add_theme_stylebox_override("panel",cardStyle)
	create_commands("Func Start",SongGQCodeCommandEnum.new().startMethod)
	unfocus_info()

#创建退出方法
func create_commands_exit():
	nowChooseFunc = "Exit"
	var s = startArea.get_parent().get_parent()
	var e = exitArea.get_parent().get_parent()
	e.add_theme_stylebox_override("panel",cardChooseStyle)
	s.add_theme_stylebox_override("panel",cardStyle)
	create_commands("Func Exit",SongGQCodeCommandEnum.new().exitMethod)
	unfocus_info()

#创建命令
func create_commands(tip_name,method):
	clear_commands()
	
	#创建提示
	var commandGenTip = Label.new()
	var commandGenTipmarg = MarginContainer.new()
	commandGenTipmarg.add_theme_constant_override("margin_left",22)
	commandGenTipmarg.add_theme_constant_override("margin_right",5)
	commandGenTipmarg.add_theme_constant_override("margin_top",1)
	commandGenTipmarg.add_theme_constant_override("margin_bottom",1)
	commandGenTip.text = tip_name
	commandGenTip.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	commandGenTip.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	commandGenTipmarg.add_child(commandGenTip)
	commands.add_child(commandGenTipmarg)
	
	#创建选项
	for item in method:
		var marg = MarginContainer.new()
		marg.add_theme_constant_override("margin_left",22)
		marg.add_theme_constant_override("margin_right",5)
		marg.add_theme_constant_override("margin_top",1)
		marg.add_theme_constant_override("margin_bottom",1)
		var command = Button.new()
		command.text = item
		marg.add_child(command)
		commands.add_child(marg)
		command.toggle_mode  = true
		command.button_group = commandBtnBG

#命令点击
func command_pressed(btn):
	var text = process_data.process_name.trim_suffix("Process")+btn.text+"Command"
	match nowChooseFunc:
		"Start" : 
			process_data.start.append(text)
			append_Command(startArea,text)
		"Exit"  : 
			process_data.exit.append(text)
			append_Command(exitArea,text)

#删除显示详情界面
func clear_content():
	for item in area.get_children():
		area.remove_child(item)

#删除显示命令列表
func clear_commands():
	for item in commands.get_children():
		commands.remove_child(item)
