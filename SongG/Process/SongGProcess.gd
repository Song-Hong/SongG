extends IProcess
class_name SongGProcess

#软件的入口
func start():
	#显示状态栏
	StatusBar.init.show_stauts()

	var tcp = Server.init.create_tcps("tcp_server","47.117.166.125",1728)
	tcp.connect_server()
	tcp.receive_data.connect(Callable(self,"on_receive_data"))

var i =0
func update(_delta):
	i+=1
	if i == 200:
		#var tcp = Server.init.get_tcp("tcp_server")
		#tcp.send_data("Hello")
		i = 0

func on_receive_data(data):
	print(data)