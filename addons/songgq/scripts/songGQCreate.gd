class_name songGQCreate

var QChat:songQChat

func _init(text:String,Q:songQChat):
	QChat = Q
	text  = text.replace(" ","")
	if len(text) <= 1 : 
		showTip()
		return
		
	var code = text[0]+text[1]
	if len(text.trim_prefix(code)) <= 0:
		showTip()
		return
		
	var path = text.trim_prefix(code)
	match code:
		"-c": SongGCodeGen.new(path,SongGCodeGen.genType.COMMAND,Callable(self,"showCreateFileTip"))
		"-p": SongGCodeGen.new(path,SongGCodeGen.genType.PROCESS,Callable(self,"showCreateFileTip"))

func showCreateFileTip(path):
	QChat.create_bot_chat("创建文件"+path)

func showTip():
	QChat.create_bot_chat(
		"-c <文件名> 创建命令文件\n"+
		"-p <文件名> 创建流程文件"
	)

