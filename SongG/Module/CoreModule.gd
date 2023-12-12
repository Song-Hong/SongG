extends IModule
class_name Core
static var init:Core
func _init():init = self

func _ready():
	Process.init.change_process(SongGProcess.new())

func set_window_size(wnd_size:Vector2i):
	get_window().size = wnd_size

func set_window_position():
	get_window().position = Vector2i(0, 0)