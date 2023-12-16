##
# 逻辑层
# 流程模块,让游戏运行更具有条例性
##
extends Node
class_name IProcess

func start():pass

func update(_delta):pass

func exit():pass

func change_process(process:IProcess):
	Process.init.change_process(process)
