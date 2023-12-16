##
# 对命令集合进行管理
##
extends IModule
class_name Commands
static var init:Commands
func _init():init = self

#每帧更新
signal update

#命令组
var commandArrays      : Array[CommandArray]
var multiCommandArrays : Array[CommandArray]

#创建CommandArray
func create_CommandArray(_commandArrayName = "")->CommandArray:
	var commandArray = CommandArray.new()
	commandArray.array_name = _commandArrayName
	commandArrays.append(commandArray)
	commandArray.all_finshed.connect(Callable(self,"remove_CommandArray"))
	return commandArray

#添加CommandArray
func append_CommandArray(commands:CommandArray):
	commandArrays.append(commands)

# 删除CommandArrray
# 当命令集执行完毕后会自动执行
func remove_CommandArray(commands:CommandArray):
	commandArrays.clear()
	commandArrays.erase(commands)

#创建并行命令集合
func create_CommandArray_multi(_commandArrayName = "")->MultiCommandArray:
	var commandArray = MultiCommandArray.new()
	commandArray.array_name = _commandArrayName
	multiCommandArrays.append(commandArray)
	return commandArray

#添加并行命令集合
func append_CommandArray_multi(commands:MultiCommandArray):
	multiCommandArrays.append(commands)

#删除并行命令集合
func remove_CommandArray_multi(commands:MultiCommandArray):
	multiCommandArrays.clear()
	multiCommandArrays.erase(commands)

#会调每帧更新
func _process(delta):
	update.emit(delta)