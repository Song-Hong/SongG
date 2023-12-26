@tool
extends IModule

var now_data:SongGCodeData
var data:BlackboardData

func _ready():
	init()

func init():
	data = BlackboardData.new()
	data.append("scene",self)
	data.append("is_init",false)
	songgvisualLoadConfigCommand.new(data).start()    #加载配置文件
	songgvisualInitDataCommand.new(data).start()      #初始化数据
	songgvisualInitSceneCommand.new(data).start()     #初始化场景
	songgvisualBindEventCommand.new(data).start()     #绑定场景事件
	songgvisualScanProcessCommand.new(data).start()   #扫描流程文件
	songgvisualClearFileAreaCommand.new(data).start() #清空文件区域
	data.append("is_init",true)
	data.set_data("nowProcess",null)
	data.get_data("filePathBtn").text = ""

#添加流程
func add_process():
	var btn = data.get_data("addProcessBtn")
	songgvisualAddProcessCommand.new(data).start()

#回到最顶端
func to_top():
	var scroll = data.get_data("scrollProcess") as ScrollContainer
	scroll.get_v_scroll_bar().value = 0

#回到最底部
func to_bottom():
	var scroll = data.get_data("scrollProcess") as ScrollContainer
	var max    = scroll.get_v_scroll_bar().max_value
	scroll.get_v_scroll_bar().value = max

#流程按钮点击
func process_click(btn):
	if data.get_data("nowProcess") != null and btn.text == data.get_data("nowProcess").text:
		return
	data.set_data("nowProcess",btn)
	load_process_file(btn.text)
	var fileArea   = data.get_data("fileArea")
	for item in fileArea.get_children():
		var f_btn = item.get_child(0)
		if f_btn.text == btn.text:
			f_btn.button_pressed = true
			set_now_file_close(f_btn)
			return
	songgvisualAddFileProcessCommand.new(data).start()

#文件点击
func file_click(btn):
	#选中当前选中的流程
	if data.get_data("nowProcess") != null and btn.text == data.get_data("nowProcess").text:
		return
	set_now_file_close(btn)
	data.set_data("nowProcess",btn)
	load_process_file(btn.text)
	var fileArea   = data.get_data("processArea")
	for item in fileArea.get_children():
		var f_btn = item.get_child(0)
		if f_btn.text == btn.text:
			f_btn.button_pressed = true
			return

#设置关闭按钮
func set_now_file_close(btn):
	var nowFile = data.get_data("nowFile")
	if nowFile != null:
		nowFile.get_parent().remove_child(nowFile)
	var close  = Button.new()
	close.toggle_mode    = true
	close.button_pressed = true
	close.text = "X"
	close.pressed.connect(Callable(self,"close_now_file"))
	btn.get_parent().add_child(close)
	data.set_data("nowFile",close)

#关闭当前文件
func close_now_file():
	var nowFile = data.get_data("nowFile")
	if nowFile == null:return
	var hbox = nowFile.get_parent()
	hbox.get_parent().remove_child(hbox)
	data.del_data("nowFile") 
	data.del_data("nowProcess")
	var spc = songgvisualShowProcessContentCommand.new(data)
	spc.clear_commands()
	spc.clear_content()
	data.get_data("filePathBtn").text = ""

#加载流程文件
func load_process_file(process_name:String):
	if data.get_data("is_init"):
		var codeParsing = SongGCodeParsing.new(process_name)
		now_data = codeParsing.parsing_file_2_SongGCodeData()
		data.set_data("nowProcessData",now_data)
		songgvisualShowProcessContentCommand.new(data).start()

#生成文件
func generate_file():
	if data.get_data("nowFile")    == null:return 
	if data.get_data("nowProcess") == null:return
	if now_data                    == null:return
	var commandGen = SongGQCodeCommandGenerate.new()
	commandGen.generates(now_data.start,now_data.process_name)
	commandGen.generates(now_data.exit,now_data.process_name)
	var codeGen  = SongGCodeGenerate.new(now_data.process_name)
	codeGen.set_data(now_data)
	codeGen.generate_file()

func _process(delta):
	pass
