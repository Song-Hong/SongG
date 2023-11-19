#############################################
# de_zh  : 
# de_en  : 
# author : Song
# time   : 2023/11/09 21:09
#############################################
extends IServer
class_name ServerMoudle_HTTP

func connect_server():
	pass

func GET(url):
	var client = HTTPClient.new()
	client.connect("request_completed",Callable(self, "_on_request_completed"))
	var fields = {"username" : "user", "password" : "pass"}
	var query_string = client.query_string_from_dict(fields)
	var headers = ["Content-Type: application/x-www-form-urlencoded", "Content-Length: " + str(query_string.length())]
	var result = client.request(HTTPClient.METHOD_GET, "/index.php", headers, query_string)
	client.request(HTTPClient.METHOD_GET,"",headers,"")

func _on_request_completed(client, response_code, response_headers, body):
	if (response_code >= 200 && response_code < 400) :
		print("成功!")
	else :
		print("失败!")
