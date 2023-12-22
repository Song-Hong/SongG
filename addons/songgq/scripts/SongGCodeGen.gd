class_name SongGCodeGen

var title = """##
# de_zh  : 
# author : HongSong
# time   : TIME
##
"""

var command_body = """extends ACommand
class_name FILENAME

#命令开始
func start():
	exec_finshed()
"""

var process_body = """extends AProcess
class_name FILENAME

#命令开始
func start():
	pass
"""

enum genType
{
	COMMAND,
	PROCESS
}

func _init(filename:String,type:genType,end_call:Callable):
	var final = ""
	var time  = Time.get_datetime_dict_from_system()
	var TIME  = ""
	TIME     += str(time.year)+"/"+str(time.month)+"/"+str(time.day)+" "
	TIME     += str(time.hour)+":"+str(time.minute)
	final    += title.replace("TIME",TIME)
	match type:
		genType.PROCESS : final+=process_body.replace("FILENAME",filename)
	var dir  = EditorPlugin.new().get_editor_interface().get_current_directory()
	var path = dir+filename+".gd"
	var f    = FileAccess.open(path,FileAccess.WRITE)
	f.store_string(final)
	end_call.callv([path])
