#窗口初始化
@tool
extends IState
class_name SongG_PM_Init

var area

func on_enter():
	#var scroll = ScrollContainer.new()
	#var area   = VBoxContainer.new()
	#scroll.add_child(area)
	#finite.own.get_child(1).add_child(area)
	area = finite.own.get_child(1)

	var process = SonG_PM_Process.new(10,10,5)
	area.add_child(process)
	var command1 = SongG_PM_Command.new(process.get_command_po())
	var command2 = SongG_PM_Command.new(process.get_command_po())
	var command3 = SongG_PM_Command.new(process.get_command_po())
	var command4 = SongG_PM_Command.new(process.get_command_po())
	var command5 = SongG_PM_Command.new(process.get_command_po())
	area.add_child(command1)
	area.add_child(command2)
	area.add_child(command3)
	area.add_child(command4)
	area.add_child(command5)

func on_stay(_delta):
	pass