extends Node
class_name SongG

static var views:Dictionary

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
