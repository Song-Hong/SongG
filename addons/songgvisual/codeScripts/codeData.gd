@tool
class_name SongGCodeData

#流程路径
const process_path = "res://scripts/process/"

var description:Dictionary = {} #注释
var extendsDic:Dictionary  = {} #继承
var process_name:String    = "" #流程名称
var start:Array[String]    = [] #开始流程
var state:Array[String]    = [] #状态流程
var update:Array[String]   = [] #更新流程
var exit:Array[String]     = [] #退出流程

#初始化
func _init(_processName:String):
	process_name = _processName

#获取文件路径 
func get_file_path()->String:
	return process_path+"%s.gd"%process_name

#设置数据
func set_data(data:SongGCodeData):
	description  = data.description
	extendsDic   = data.extendsDic
	process_name = data.process_name
	start        = data.start
	state        = data.state
	update       = data.update
	exit         = data.exit
