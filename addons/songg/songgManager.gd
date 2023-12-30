##
# de_zh  : songg管理器插件场景
# author : HongSong
# time   : 2023/12/28 18:03
##
@tool
extends PanelContainer

#按钮组
@export var btns:ButtonGroup
@export var area:Control

var data:BlackboardData #数据
var nbtn:Button         #当前按下的按钮
var nsce                #当前的场景
	
func _ready():
	#连接导航栏按钮
	btns.pressed.connect(Callable(self,"module_btn_pressed"))

#按钮点击
func module_btn_pressed(btn:BaseButton):
	match btn.name:
		"Universal" : init_module(btn.name)
		"Process"   : init_module(btn.name)
		_           : 
			btn.button_pressed = false
			if nbtn != null:
				nbtn.button_pressed = true
			return
	nbtn = btn

#初始化模块
func init_module(module_name:String):
	var scene = load("res://addons/songg/scenes/%s.tscn"%module_name).instantiate()
	if nsce != null:
		area.remove_child(nsce)
	nsce = scene
	area.add_child(scene)
