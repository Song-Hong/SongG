##
# type   : class
# de_zh  : 命令集
# author : HongSong
# time   : 2023/12/20 15:50
##
extends Node
class_name CommandArray

#全部执行完毕
signal all_finshed
#执行错误
signal error

#集合名称
var array_name  : String
#命令集合
var commands    : Array[ACommand]
#当前执行的命令
var now_command : ACommand

#快速添加
func Q(commands_name:String,commands:Array[ACommand],end_call=null):
	array_name = commands_name
	for command in commands:
		append(command)
	if end_call != null:
		end_call.call()

#添加命令
func append(command:ACommand,command_name=""):
	command.command_name = command_name
	commands.append(command)

#开始命令集
func start():
	exec_command()

#运行
func exec_command():
	if commands.size() == 0:
		now_command = null
		self.all_finshed.emit(self)
		return
	now_command = commands[0]
	Commands.init.update.connect(Callable(now_command, "update"))
	now_command.error.connect(Callable(self, "exec_error"))
	now_command.finshed.connect(Callable(self, "exec_finshed"))
	now_command.start()

#当前命令允许完成
func exec_finshed():
	if now_command != null:
		now_command.exit()
	Commands.init.update.disconnect(Callable(now_command, "update"))
	now_command.error.disconnect(Callable(self, "exec_error"))
	now_command.finshed.disconnect(Callable(self, "exec_finshed"))
	commands.erase(now_command)
	exec_command()

#运行错误,打断后续运行,清空当前命令集
func exec_error():
	clear()
	error.emit()

#清空命令集合
func clear():
	if Commands.init.update.is_connected(Callable(now_command, "update")):
		Commands.init.update.disconnect(Callable(now_command, "update"))
	commands.clear()
