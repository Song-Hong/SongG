@tool
class_name SongGQCodeCommandGenerate

#生成多个
func generates(commands:Array[String],process_name:String=""):
	for command in commands:
		generate(command,process_name)

#生成
func generate(command:String,process_name:String=""):
	process_name = process_name.trim_suffix("Process")
	command = command.trim_prefix(process_name)
	command = command.trim_suffix("Command")
	match command:
		"InitScene"        : InitScene(process_name)
		"BindEvent"        : BindEvent(process_name)
		"RemoveScene"      : RemoveScene(process_name)
		"UnbindEvent"      : UnbindEvent(process_name)
		"ClearBlackboard" : ClearBlackboard(process_name)

#初始化场景
func InitScene(process_name):
	var content = generate_description("初始化场景")
	content += """
extends ACommand
class_name CLASSNAME

func start():
	var scene = Scene.init.add_scene("PROCESSNAME")
	var bd = BlackboardData.new()
	for item in scene.get_children():
		bd.set_data(item.name,item)
	Blackboard.init.set_blackboard("PROCESSNAME",bd)
	exec_finshed()
	pass
	"""
	var classname = process_name+"InitSceneCommand"
	content = content.replace("CLASSNAME",classname)
	content = content.replace("PROCESSNAME",process_name)
	save_file(content,get_path(process_name,classname))

#绑定按钮命令
func BindEvent(process_name):
	var content = generate_description("绑定按钮")
	content += """
extends ACommand
class_name CLASSNAME

func start():
	exec_finshed()
	pass
	"""
	var classname = process_name+"BindEventCommand"
	content = content.replace("CLASSNAME",classname)
	save_file(content,get_path(process_name,classname))

#删除场景
func RemoveScene(process_name):
	var content = generate_description("绑定按钮")
	content += """
extends ACommand
class_name CLASSNAME

func start():
	Scene.init.remove_scene("PROCESSNAME")
	exec_finshed()
	pass
	"""
	var classname = process_name+"RemoveSceneCommand"
	content = content.replace("CLASSNAME",classname)
	content = content.replace("PROCESSNAME",process_name)
	save_file(content,get_path(process_name,classname))

#删除场景
func UnbindEvent(process_name):
	var content = generate_description("绑定按钮")
	content += """
extends ACommand
class_name CLASSNAME

func start():
	exec_finshed()
	pass
	"""
	var classname = process_name+"UnbindEventCommand"
	content = content.replace("CLASSNAME",classname)
	save_file(content,get_path(process_name,classname))

#清理黑板
func ClearBlackboard(process_name):
	var content = generate_description("清理黑板数据")
	content += """
extends ACommand
class_name CLASSNAME

func start():
	Blackboard.init.del_blackboard("PROCESSNAME")
	exec_finshed()
	pass
	"""
	var classname = process_name+"ClearBlackboardCommand"
	content = content.replace("CLASSNAME",classname)
	content = content.replace("PROCESSNAME",process_name)
	save_file(content,get_path(process_name,classname))

#生成注释
func generate_description(desc="")->String:
	var des = """##
# de_zh  : DE_ZH
# author : HongSong
# time   : TIME
##
	"""
	var time     = Time.get_datetime_dict_from_system()
	var _time = str(time.year)+"/"+str2(time.month)+"/"+str2(time.day)+" "+str2(time.hour)+":"+str2(time.minute)
	des = des.replace("TIME",_time)
	des = des.replace("DE_ZH",desc)
	return des

#转为两位字符串
func str2(time):
	var times = str(time)
	if len(times)<2:
		times = "0"+times
	return times

#获取路径
func get_path(process_name:String,command_name:String)->String:
	var path = "res://scripts/commands/%s/"%process_name
	path    += "%s.gd"%command_name
	return path

#存储文件
func save_file(content:String,path:String):
	if FileAccess.file_exists(path):return
	var dir = path.substr(0,path.rfind("/"))
	if !DirAccess.dir_exists_absolute(dir):
		DirAccess.make_dir_recursive_absolute(dir)
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(content)
	print("创建文件: "+path)
