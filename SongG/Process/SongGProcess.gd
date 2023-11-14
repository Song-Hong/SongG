extends IProcess
class_name SongGProcess

#软件的入口
func start():
	#显示状态栏
	StatusBar.init.show_stauts()
	var evenState = EvenStateTimer.new(120)
	evenState.connect("finshed",Callable(self,"finshed"))
	EvenState.init.create(evenState)
	
func finshed():
	print("结束")

var i = 0
func update(_delta):
	i+=1
	if i == 200:
		EvenState.init.create(EvenStateTimer.new(6))
		i=0
