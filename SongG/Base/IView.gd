##
# 视图层
# 负责简单的视图管理
# 提交至SongG管理模块,方便与与View层进行交互
##
extends Node
class_name IView
func name():pass

func _init():
	SongG.set_view(name(),self)

func _exit_tree():
	SongG.remove_view(name())
