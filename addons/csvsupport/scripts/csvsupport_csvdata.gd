#CSV文件
@tool
extends Node
class_name csvsupport_csvdata

var data  = []
var max_x = 0
var max_y = 0

#初始化
func _init():
	pass
	
#获取值
func get_value(x:int,y:int):
	if x > max_x || y > max_y:
		return ""
	return data[x][y]

#设置数据
func set_value(x,y,value):
	if x > max_x:
		fill_row(max_x-x)
	if y > max_y:
		fill_row(max_y-y)
	data[x][y] = value

#to string
func to_str()->String:
	var content = ""
	for x in range(max_x):
		for y in range(max_y):
			content+= str(data[x][y])+","
		if content.ends_with(","):
			content = content.trim_suffix(",")
		content+="\n"
	return content

#添加行
func add_row(x:int,list:Array):
	if x >= max_x:
		fill_row(x-max_x+1)
	for li in list:
		data[x].append(li)
	var list_len = len(list)
	if list_len > max_y:
		max_y = list_len
	
#添加列
func add_col(y:int,list:Array):
	if y >= max_y:
		fill_col(y-max_y+1)
	for i in range(max_x):
		data[i][max_y-1] = list[i]

#填充行
func fill_row(x:int):
	for i in range(x):
		data.append([])
		max_x += 1

#填充列
func fill_col(y:int):
	for i in range(y):
		for i_x in range(max_x):
			data[i_x].append("")
		max_y+=1
