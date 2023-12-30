##
# de_zh  : 初始化框架
# author : HongSong
# time   : 2023/12/30 16:39
##
@tool
extends ACommand
class_name universalModuleInitSongGCommand

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

#开始执行
func start():
	create_dir("res://SongGConfig")
	create_init_file("res://SongGConfig/core.json")
	update_file()
	exec_finshed()

#创建初始化文件
func create_init_file(path):
	var content = {
		"startProcess":""
	}
	create_file(path,JSON.stringify(content))

func update_file():
	var file = FileAccess.open(configPath,FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	json["isinit"] = true
	file.close()
	file = FileAccess.open(configPath,FileAccess.WRITE)
	file.store_string(JSON.stringify(json))

#创建文件夹
func create_dir(path):
	if !DirAccess.dir_exists_absolute(path):
		DirAccess.make_dir_recursive_absolute(path)
		print("创建文件夹:",path)

#创建文件
func create_file(path,content):
	if !FileAccess.file_exists(path):
		var file = FileAccess.open(path,FileAccess.WRITE)
		file.store_string(content)
		print("创建文件:",path)
