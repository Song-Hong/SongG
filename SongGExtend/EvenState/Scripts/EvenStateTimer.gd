extends IEvenState
class_name EvenStateTimer

#显示节点
var lable

#时间变量
var time

func _init(t=30):
	time = t

func start():
	scene = preload("res://SongGExtend/EvenState/Scenes/timer.tscn").instantiate()
	connect("process",Callable(self,"on_process"))
	lable = scene.get_child(1)
	Thread.new().start(Callable(self,"timer"))
	#scene.connect("pressed",Callable(self,"pressed"))
	return scene

func pressed():
	print("点击")

func on_process(delta):
	covter2String()

func timer():
	while time:
		sleep(1)     
		time-=1

func covter2String():
	var m = time/60
	var s = time-m*60
	lable.text = time2str2(m)+":"+time2str2(s)
	if !time:
		disconnect("process",Callable(self,"on_process"))
		finshed.emit()
		destory.emit(self)
		
func time2str2(time:int)->String:
	var t = str(time) 
	if time == 0:
		t = "00"
	elif len(t) < 2:
		t = "0"+t
	return t
