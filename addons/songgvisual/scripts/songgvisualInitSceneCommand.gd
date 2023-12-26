@tool
extends ACommand
class_name songgvisualInitSceneCommand

var data:BlackboardData

#初始化
func _init(_data:BlackboardData):
	data = _data

func start():
	#获取场景内信息
	var scene          = data.get_data("scene")
	
	## 获取左侧面板信息
	#获取左侧面板流程区域
	var leftMenu       = scene.get_child(0).get_child(0).get_child(0)
	var scrollProcess  = leftMenu.get_child(1)
	var processArea    = scrollProcess.get_child(0)
	#获取左侧面板工具栏按钮
	var tools          = leftMenu.get_child(0).get_child(0).get_child(1).get_child(0)
	var addProcessBtn  = tools.get_child(0)
	var toTopBtn       = tools.get_child(1)
	var toBottomBtn    = tools.get_child(2)
	#获取左侧面板标题
	var pluginsName    = leftMenu.get_child(0).get_child(0).get_child(0).get_child(0)
	
	##获取顶部面板区域
	var rightContainer = scene.get_child(0).get_child(1)
	var fileArea       = rightContainer.get_child(0).get_child(0).get_child(0)
	var contentPanel   = rightContainer.get_child(1).get_child(0).get_child(0)
	var commandsPanel  = rightContainer.get_child(1).get_child(1).get_child(0).get_child(0)
	
	##获取底部区域
	var bottomArea     = rightContainer.get_child(2).get_child(0).get_child(0)
	var filePathBtn    = bottomArea.get_child(0)
	var fileGenBtn     = bottomArea.get_child(1)
	
	#设置数据至黑板
	data.set_data("pluginsName",pluginsName)
	data.set_data("scrollProcess",scrollProcess)
	data.set_data("processArea",processArea)
	data.set_data("addProcessBtn",addProcessBtn)
	data.set_data("toTopBtn",toTopBtn)
	data.set_data("toBottomBtn",toBottomBtn)
	data.set_data("fileArea",fileArea)
	data.set_data("contentPanel",contentPanel)
	data.set_data("commandsPanel",commandsPanel)
	data.set_data("filePathBtn",filePathBtn)
	data.set_data("fileGenBtn",fileGenBtn)
	
	exec_finshed()
