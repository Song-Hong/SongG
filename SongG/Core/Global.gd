#############################################
# de_zh  : 公共类
# de_en  : 
# author : HongSong
# time   : 2023/10/25 16:57
#############################################
extends Node

var utility : Dictionary
var model   : Dictionary
var system  : Dictionary
var view    : Dictionary

#
func get_utility(utility_name):
	if utility.has(utility_name):
		return utility[utility_name]
	return null

#
func add_utility(utility_name,new_utility:IUtility):
	utility[utility_name] = new_utility

#
func get_model(model_name):
	if model.has(model_name):
		return model[model_name]
	return null

#
func add_model(model_name,new_model:IModel):
	model[model_name] = new_model

#
func get_system(system_name):
	if system.has(system_name):
		return system[system_name]
	return null

#
func add_system(system_name,new_system:ISystem):
	system[system_name] = new_system
	
#
func get_view(view_name):
	if view.has(view_name):
		return view[view_name]
	return null

#
func add_view(view_name,new_view:IView):
	view[view_name] = new_view
