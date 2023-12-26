##
# 代码解析
##
@tool
extends SongGCodeData
class_name SongGCodeParsing

#解析文件转为数据
func parsing_file_2_SongGCodeData()->SongGCodeData:
	parsing_file()
	var data = SongGCodeData.new(process_name)
	data.description  = description
	data.extendsDic   = extendsDic
	data.process_name = process_name
	data.start        = start
	data.state        = state
	data.update       = update
	data.exit         = exit
	return data

#解析文件
func parsing_file():
	var path    = get_file_path()
	if !FileAccess.file_exists(path):return
	var file    = FileAccess.open(path,FileAccess.READ)
	parsing(file.get_as_text())

#开始解析
func parsing(content:String):
	content = parsing_description(content)
	content = parsing_extend(content)
	content = parsing_start(content)
	content = parsing_exit(content)
	
#解析注释
func parsing_description(content:String)->String:
	if content.begins_with("##"):
		var contents = content.split("\n")
		var index = 0
		var end_index = 1
		for item in contents:
			if item.begins_with("##"): 
				index+=1
				if index >= 2:
					break
			elif item.begins_with("#"):
				var value = item.trim_prefix("#")
				var items = value.split(":")
				if items.size() >= 2:
					var k = items[0].replace(" ","")
					var v = items[1].replace(" ","")
					description[k] = v
			else:
				break
			end_index+=1
		var parsing_value = ""
		for item in range(end_index):
			parsing_value += contents[item]+"\n"
		content = content.replace(parsing_value,"")
		return content
	else:
		return content

#解析扩展
func parsing_extend(content:String)->String:
	var extndsStart   = content.find("extends")
	if extndsStart >= 0:
		content        = content.erase(0,extndsStart)
		var extendsEnd = content.find("\n")
		if extendsEnd >= 0:
			var value = content.substr(0,extendsEnd)
			content   = content.erase(0,extendsEnd+len("\n"))
			value = value.trim_prefix("extends")
			value = value.replace(" ","")
			value = value.replace("\n","")
			extendsDic["extends"] = value
	var classNameStart   = content.find("class_name")
	if classNameStart >= 0:
		content        = content.erase(0,classNameStart)
		var classNameEnd = content.find("\n")
		if classNameEnd >= 0:
			var value = content.substr(0,classNameEnd)
			content   = content.erase(0,classNameEnd+len("\n"))
			value = value.trim_prefix("class_name")
			value = value.replace(" ","")
			value = value.replace("\n","")
			extendsDic["class_name"] = value
	return content

#解析开始流程
func parsing_start(content: String)->String:
	var startStart = content.find("func start():\n")
	if startStart > 0:
		content = content.erase(0,startStart)
	else:
		return content
	var startEnd   = content.find("pass")
	if startEnd > 0:
		var startContent = content.substr(0,startEnd+len("pass\n"))
		content = content.replace(startContent,"")
		startContent = startContent.replace("func start():\n","")
		startContent = startContent.replace("pass\n","")
		startContent = startContent.replace("\t","")
		for item in startContent.split("\n"):
			if item.find("Command") > 0:
				var index = item.find(".")
				if index > 0:
					var value = item.substr(0,index)
					start.append(value)
	return content

#解析状态
func parsing_state():
	pass

#解析更新流程
func parsing_update():
	pass

#解析退出流程
func parsing_exit(content:String)->String:
	var exitStart = content.find("func exit():\n")
	if exitStart > 0:
		content = content.erase(0,exitStart)
	else:
		return content
	var exitEnd   = content.find("pass")
	if exitEnd > 0:
		var exitContent = content.substr(0,exitEnd+len("pass\n"))
		content = content.replace(exitContent,"")
		exitContent = exitContent.replace("func exit():\n","")
		exitContent = exitContent.replace("pass\n","")
		exitContent = exitContent.replace("\t","")
		for item in exitContent.split("\n"):
			if item.find("Command") > 0:
				var index = item.find(".")
				if index > 0:
					var value = item.substr(0,index)
					exit.append(value)
	return content
