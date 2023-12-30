##
# de_zh  : 初始化universal配置文件
# author : HongSong
# time   : 2023/12/30 16:39
##
@tool
extends ACommand
class_name universalModuleInitCommand

#场景数据
var scene
#黑板数据
var data:BlackboardData
#配置文件路径
var configPath = "res://addons/songg/config/universal.json"

#初始化
func _init(_scene,_data:BlackboardData):
	scene = _scene
	data=_data

#初始化数据
func start():
	var file = FileAccess.open(configPath,FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	
	#检查是否初始化
	if !json["isinit"]:
		scene.init_songg()
	exec_finshed()
