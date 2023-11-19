extends IProcess
class_name SongGProcess

#软件的入口
func start():
	#显示状态栏
	StatusBar.init.show_stauts()

var i =0
func update(_delta):
	i+=1
	if i == 200:
		pass
