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
		var tip = TipPanel.new("软件更新","当前软件版本过低","","取消")
		Tip.init.create_tip(tip)
