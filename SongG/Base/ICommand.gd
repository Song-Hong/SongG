#############################################
# de_zh  : 命令模式基类
# de_en  : 
# author : HongSong
# time   : 2023/10/25 09:43
#############################################
extends Node
class_name ICommand

#信号绑定
func bind(target,signal_str:String):
	target.connect(signal_str,Callable(self,"exec"))

func bindv(target,signal_str:String,args:Array):
	var exec_callv = Callable(self,"execv")
	exec_callv.bindv(args)
	target.connect(signal_str,exec_callv)

func exec():pass

func execv(args:Array):pass
