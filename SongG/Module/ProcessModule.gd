extends IModule
class_name Process
static var init:Process
func _init():init = self

var now_process:IProcess

func change_process(process:IProcess):
	if now_process != null:
		now_process.exit()
	now_process = process
	now_process.start()

func _process(delta):
	if now_process != null:
		now_process.update(delta)
