@tool
extends ACommand
class_name songgvisualBindEventCommand

var data:BlackboardData

#初始化
func _init(_data:BlackboardData):
	data = _data

func start():
	var scene          = data.get_data("scene")
	var pluginsNameBtn = data.get_data("pluginsName")
	var addProcessBtn  = data.get_data("addProcessBtn")
	var toTopBtn       = data.get_data("toTopBtn")
	var toBottomBtn    = data.get_data("toBottomBtn")
	var processBtnBG   = data.get_data("processBG")
	var fileBtnBG      = data.get_data("fileBG")
	var fileGenBtn     = data.get_data("fileGenBtn")
	
	#插件名称点击
	var pluginsNameBtnCall = Callable(scene,"init")
	if !pluginsNameBtn.pressed.is_connected(pluginsNameBtnCall):
		pluginsNameBtn.pressed.connect(pluginsNameBtnCall)
	
	#绑定添加流程按钮
	var addProcessBtnCall = Callable(scene,"add_process")
	if !addProcessBtn.pressed.is_connected(addProcessBtnCall):
		addProcessBtn.pressed.connect(addProcessBtnCall)
	
	#左侧工具栏按钮 点击前往最顶部按钮
	var toTopBtnCall = Callable(scene,"to_top")
	if !toTopBtn.pressed.is_connected(toTopBtnCall):
		toTopBtn.pressed.connect(toTopBtnCall)
	
	#左侧工具栏按钮 点击前往最底部按钮
	var toBottomBtnCall = Callable(scene,"to_bottom")
	if !toBottomBtn.pressed.is_connected(toBottomBtnCall):
		toBottomBtn.pressed.connect(toBottomBtnCall)
	
	#流程按钮点击
	var processBtnBGCall  = Callable(scene,"process_click")
	if !processBtnBG.pressed.is_connected(processBtnBGCall):
		processBtnBG.pressed.connect(processBtnBGCall)
	
	#文件按钮点击
	var fileBtnBGCall = Callable(scene,"file_click")
	if !fileBtnBG.pressed.is_connected(fileBtnBGCall):
		fileBtnBG.pressed.connect(fileBtnBGCall)
	
	#生成按钮点击
	var fileGenBtnCall = Callable(scene,"generate_file")
	if !fileGenBtn.pressed.is_connected(fileGenBtnCall):
		fileGenBtn.pressed.connect(fileGenBtnCall)
		
	exec_finshed()
