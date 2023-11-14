extends Node
class_name IProcess

func start():pass

func update(_delta):pass

func exit():pass

func change_process(process:IProcess):
	Process.init.change_process(process)
