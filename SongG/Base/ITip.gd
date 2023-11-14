extends Control
class_name ITip

#Tips设置
var can_move = true     #窗口是否可以移动
var can_do 

#窗口移动变量
var isdown    = false   #检测鼠标是否按下
var offset              #偏移值

func _ready():
	connect("button_down",Callable(self,"_on_button_down"))
	connect("button_up",Callable(self,"_on_button_up"))
	showTip()

func Close():
	pass

##regin 窗口的移动操作
#当鼠标按下时候,开始跟手
func _on_button_down():
	offset = get_global_mouse_position() - position
	isdown = true

#当鼠标抬起时,停止跟手
func _on_button_up():
	isdown = false

#当鼠标按下时,持续跟手操作
func _input(_event):
	if isdown:
		position = get_global_mouse_position()-offset
##endregin

##regin 用户可扩展方法
#显示提示窗口
func showTip():pass
##endregin
