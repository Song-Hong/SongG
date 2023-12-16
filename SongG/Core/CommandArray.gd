##
# 串行命令集合
# 负责顺序处理命令集
##
extends Node
class_name CommandArray

signal all_finshed
signal error

var array_name  : String
var commands    : Array[ICommand]
var now_command : ICommand

#添加命令
func append(command:ICommand,command_name=""):
	command.command_name = command_name
	commands.append(command)

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


func clear():
	if Commands.init.update.is_connected(Callable(now_command, "update")):
		Commands.init.update.disconnect(Callable(now_command, "update"))
	commands.clear()