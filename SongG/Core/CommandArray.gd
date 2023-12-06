extends Node
class_name CommandArray

signal all_finshed
signal error

var array_name  : String
var commands    : Array[ICommand]
var now_command : ICommand

func append(command:ICommand):
	commands.append(command)

func start():
	exec_command()

#运行
func exec_command():
	if commands.size() == 0:
		now_command = null
		self.all_finshed.emit()
		return
	now_command = commands[0]
	commands[0].start()
	commands[0].finshed.connect(Callable(self, "exec_finshed"))
	commands[0].error.connect(Callable(self, "exec_error"))

#当前命令允许完成
func exec_finshed():
	if now_command != null:
		now_command.finsh()
	commands.erase(now_command)
	exec_command()

#运行错误,打断后续运行,清空当前命令集
func exec_error():
	error.emit()
