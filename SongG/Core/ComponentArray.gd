##
# type   : class
# de_zh  : 组件集
# author : HongSong
# time   : 2023/12/20 15:50
##
extends Node
class_name ComponentArray

#集合名称
var array_name  : String
#名称
var commands    : Dictionary

#添加命令
func append(command:AComponent,command_name=""):
	command.command_name = command_name
	commands[command_name] = command
	command.start()
	Core.init.update.connect(Callable(command, "update"))

#重新开启命令
func restart(command_name:String):
	if !commands.has(command_name): return
	stop(command_name)
	start(command_name)

#开启
func start(command_name:String):
	if !commands.has(command_name): return
	commands[command_name].start()
	Nd(command_name)

#停止
func stop(command_name:String):
	if !commands.has(command_name): return
	commands[command_name].exit()
	Up(command_name)

# 挂起
# 取消绑定update
func Up(command_name:String):
	if !commands.has(command_name): return
	Core.init.update.disconnect(Callable(commands[command_name], "update"))

# 解除挂起
# 重新绑定update
func Nd(command_name:String):
	if !commands.has(command_name): return
	Core.init.update.connect(Callable(commands[command_name], "update"))

#删除命令
func destory(command_name:String):
	if !commands.has(command_name): return
	stop(command_name)
	commands.erase(command_name)

#是否存在命令
func has(command_name)->bool:
	return commands.has(command_name)

#清空全部命令
func clear():
	for command_name in commands:
		stop(command_name)
	commands.clear()