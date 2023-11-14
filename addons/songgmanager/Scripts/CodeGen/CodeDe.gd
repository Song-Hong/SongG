#############################################
# de_zh  : 代码注释解析
# de_en  : 
# author : Song
# time   : 2023/11/10 18:05
#############################################
extends Node
class_name CodeDe

var data:Dictionary

static func init(text)->CodeDe:
	var codede = CodeDe.new()
	codede.data = parse_comment(text)
	return codede

static func parse_comment(text):
	# 记录开始和结束
	var state = false
	# 将文本按行拆分
	var lines = text.split("\n")
	# 创建一个字典来存储解析后的属性
	var parsed_data = {}
	var i = 0
	# 遍历每一行
	for line in lines:
		if len(line) < 2:
			continue
		if line[1] == "#":
			if state:
				return parsed_data
			else:
				state = true
				continue
		line = line.replace(" ","").replacen("#","")
		var dir = line.split(":")
		parsed_data[dir[0]] = dir[1]
	return parsed_data

func _init(_de_zh="",_de_en="",_author="",_time=""):
	if _time == "":
		var time     = Time.get_datetime_dict_from_system()
		_time = str(time.year)+"/"+str2(time.month)+"/"+str2(time.day)+" "+str2(time.hour)+":"+str2		(time.minute)
	data["de_zh"]  = _de_zh
	data["de_en"]  = _de_en
	data["author"] = _author
	data["time"]   = _time
	
func str2(time):
	var times = str(time)
	if len(times)<2:
		times = "0"+times
	return times

func to_string()->String:
	var spliteLine = "##################################################"
	var content    = spliteLine
	for key in data.keys():
		content += "# %s : "%key
		content += "%s\n"%data[key]
	content += spliteLine
	return content
