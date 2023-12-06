extends Node
class_name IView
func name():pass

func _init():
	SongG.set_view(name(),self)

func _exit_tree():
	SongG.remove_view(name())
