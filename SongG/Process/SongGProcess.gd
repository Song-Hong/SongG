##
# type   : 流程的入口,负责初始化框架
# de_zh  : 黑板数据
# author : HongSong
# time   : 2023/12/20 15:27
##
extends AProcess
class_name SongGProcess

#软件的入口
func start():
	StatusBar.init.show_stauts()
