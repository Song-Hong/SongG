#窗口初始化
@tool
extends Control

var SongGState:Finite

func _ready():
	init_window()          #初始化窗口尺寸
	show_default_window()  #显示默认窗口
	init_state()           #初始化状态
	bind_btn_event()       #绑定按钮事件

func _process(delta):
	#SongGState._stay(delta)
	pass

#初始化窗口尺寸
func init_window():
	var width             = size.x
	var height            = size.y
	var wnd_size          = DisplayServer.screen_get_size(DisplayServer.MAIN_WINDOW_ID)
	var zoom              = Vector2(wnd_size.x/1920.0,wnd_size.y/1080.0)
	var left_panel_width  = 80*zoom.x
	get_child(0).size     = Vector2(left_panel_width,height)
	get_child(1).size     = Vector2(width-left_panel_width,height)
	get_child(0).position = Vector2(0,0)
	get_child(1).position = Vector2(left_panel_width,0)


#显示默认窗口
func show_default_window():
	var btn = get_child(0).get_child(1).get_child(0).get_child(1).get_child(0)
	btn.button_pressed = true

#初始化状态
func init_state():
	SongGState = Finite.new(self)
	SongGState.add_state("ProcessManager",SongG_PM_Init.new())
	SongGState.start("ProcessManager")

#绑定按钮事件
func bind_btn_event():
	var uni_btn = get_child(0).get_child(1).get_child(0).get_child(0).get_child(0)
	var pro_btn = get_child(0).get_child(1).get_child(0).get_child(1).get_child(0)

	uni_btn.pressed.connect(Callable(self,"show_universal_window"))
	pro_btn.pressed.connect(Callable(self,"show_process_window"))

#显示通用窗口
func show_universal_window():
	clear_content()
	print("显示通用窗口")

#显示流程窗口
func show_process_window():
	print("显示流程窗口")
	clear_content()
	SongGState.change_state("ProcessManager")

#清空内容界面
func clear_content():
	var area = get_child(1)
	for item in area.get_children():
		area.remove_child(item)
