extends IMoudle
class_name Server
static var init:Server
func _init():
	init=self

var tcp :ServerMoudle_TCP
var http:ServerMoudle_HTTP

func create_tcp():
	tcp = ServerMoudle_TCP.new()

func create_http():
	http = ServerMoudle_HTTP.new()

func _process(_delta):
	if tcp != null:
		tcp.listener()

#当退出app时
func on_exit_app():
	if tcp != null:
		tcp.disconnect_server()
