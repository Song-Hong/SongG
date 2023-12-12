extends Node
class_name SongG

static var views:Dictionary
static var temps:Dictionary

#获取模块数据
static func get_view(view_name:String)->IView:
	if views.has(view_name):
		return views[view_name]
	return null

#添加模块数据
static func set_view(view_name:String,view:IView)->void:
	if views.has(view_name):
		return
	else:
		views[view_name] = view

#删除显示模块
static func remove_view(view_name:String)->bool:
	if views.has(view_name):
		views.erase(view_name)
		return true
	else:
		return false

#获取临时数据
static func get_temp(temp_name:String):
	if temps.has(temp_name):
		return temps[temp_name]
	return null

#添加临时数据
static func set_temp(temp_name:String,temp)->void:
	if temps.has(temp_name):
		return
	else:
		temps[temp_name] = temp

#删除临时数据
static func remove_temp(temp_name:String)->bool:
	if temps.has(temp_name):
		temps.erase(temp_name)
		return true
	else:
		return false

#删除全部临时数据
static func clear_all_temp():
	temps.clear()