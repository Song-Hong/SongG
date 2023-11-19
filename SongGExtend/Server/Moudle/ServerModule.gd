extends IMoudle
class_name Server
static var init:Server
func _init():init=self

#信号
signal update

############################################
# 主体
#初始化
func _ready():
	pass

#每帧更新
func _process(_delta):
	pass

#当退出app时
func on_exit_app():
	pass

############################################
# Tcp服务器
var tcps:Dictionary

#获取tcp服务器
func get_tcp(tcp_name:String)->ServerTCP:
	if !tcps.has(tcp_name): 
		return null
	return tcps[tcp_name]

#发送数据
func send_data(tcp_name:String,data:String):
	if !tcps.has(tcp_name): 
		return null
	tcps[tcp_name].send_data(data)

#创建tcp服务器
func create_tcps(tcp_name:String,host:String,port:int)->ServerTCP:
	if !tcps.has(tcp_name):
		tcps[tcp_name] = ServerTCP.new(host,port)
	return tcps[tcp_name]

#删除tcp服务器
func destory_tcp(tcp_name:String)->bool:
	if !tcps.has(tcp_name): 
		return true
	tcps[tcp_name].dislistener()
	tcps.erase(tcp_name)
	return true
