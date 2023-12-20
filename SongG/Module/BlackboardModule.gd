##
# type   : 模块
# de_zh  : 黑板
# author : HongSong
# time   : 2023/12/20 15:25
##
extends IModule
class_name Blackboard
static var init:Blackboard
func _init():init = self

#数据
var data:Dictionary

#添加数据
func append(data_name,_data):
	data[data_name] = _data

#添加数据
func set_data(data_name,_data):
	data[data_name] = _data

#获取数据
func get_data(data_name):
	if data.has(data_name):
		return data[data_name]

#尝试获取数据
func try_get_data(data_name,call_data:Callable):
	if data.has(data_name):
		call_data.callv([data[data_name]])

#删除数据
func del_data(data_name):
	if data.has(data_name):
		data.erase(data_name)
