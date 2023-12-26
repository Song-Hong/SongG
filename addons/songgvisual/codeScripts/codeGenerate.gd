##
# de_zh  : 代码生成
# author : HongSong
# time   : 2023/12/25 21:23
##
@tool
extends SongGCodeData
class_name SongGCodeGenerate

#生成存储至文件
func generate_file():
	var path    = get_file_path()
	var file    = FileAccess.open(path,FileAccess.WRITE)
	generate()
	file.store_string(generate())
	print("创建文件:",path)

#生成
func generate()->String:
	var file_content = ""
	file_content += generate_description()
	file_content += generate_extend()
	file_content += generate_start()
	#file_content += generate_state()
	file_content += generate_update()
	file_content += generate_exit()
	return file_content

#转为两位字符串
func str2(time):
	var times = str(time)
	if len(times)<2:
		times = "0"+times
	return times

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
	if desc != "":
		des = des.replace("DE_ZH",desc)
	elif description.has("de_zh"):
		des = des.replace("DE_ZH",description["de_zh"])
	return des
	
#生成扩展
func generate_extend(_process_name="")->String:
	var ext="""
extends AProcess
class_name CLASSNAME
	"""
	if _process_name == "":
		_process_name = process_name
	ext = ext.replace("CLASSNAME",_process_name)
	return ext

#生成开始流程
func generate_start()->String:
	var content = """
#流程开始
func start():
	CommandArray.Q("PROCESS",[
COMMANDS
	])
	pass
	"""
	var commands = ""
	for item in start:
		commands +=  "\t\t%s.new(),\n"%item
	content = content.replace("PROCESS",process_name)
	content = content.replace("COMMANDS\n",commands)
	return content

#生成状态
func generate_state()->String:
	var content = """
#初始化状态
func init_Finite():
	var finite = Finite.new(Process.init)
	STATES
	START
	pass
	"""
	var states = ""
	for item in state:
		states += "\tfinite.add_state(\"%s\",%s.new())"%item
	content = content.replace("\tSTATES\n",states)
	if state.size()>0:
		content = content.replace("\tSTART\n","finite.start(\"%s\")"%state[0])
	else:
		content = content.replace("\tSTART\n","")
	return content

#生成更新流程
func generate_update()->String:
	var content = """
#流程结束
func update(delta):
	pass
	"""
	return content

#生成退出流程
func generate_exit()->String:
	var content = """
#流程结束
func exit():
EXITS
	pass
	"""
	var exits = ""
	for item in exit:
		exits += "\t%s.new().start()\n"%item
	content = content.replace("EXITS\n",exits)
	return content
