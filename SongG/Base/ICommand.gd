##
# 逻辑层
# 负责分离操作 (适用于自动化)
##
extends Node
class_name ICommand

#当命令执行完成时
signal finshed
signal error

#别名
var command_name

#可重写方法
func start():pass        #当命令开始时
func exit():pass         #当任务结束时
func update(_delta):pass #任务进行中

#快捷方法
func exec_finshed() : finshed.emit() #运行完成
func exec_error()   : error.emit()   #运行失败
