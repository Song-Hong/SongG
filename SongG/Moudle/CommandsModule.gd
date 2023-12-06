extends IMoudle
class_name Commands
static var init:Commands
func _init():init = self

#命令组
var commandArrays:Array[CommandArray]

#创建CommandArray
func create_CommandArray(_commandArrayName = "")->CommandArray:
	var commandArray = CommandArray.new()
	commandArray.array_name = _commandArrayName
	commandArrays.append(commandArray)
	return commandArray

#创建CommandArray
func append_CommandArray(commands:CommandArray):
	commandArrays.append(commands)
