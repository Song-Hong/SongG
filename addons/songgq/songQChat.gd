@tool
extends Control
class_name songQChat

var inputText:LineEdit
var chatArea:VBoxContainer

var putText:Array[String]
var putLabel:Label=null
var wait_index = 0

#style
var myChatStyle:StyleBoxFlat

func _ready():
	start()

#
func _process(delta):
	wait_index += 1
	if wait_index >= 80 and putLabel != null:
		if putText.size() <= 0:
			putLabel = null
			putText.clear()
			inputText.focus_mode = Control.FOCUS_ALL
			inputText.grab_focus()
			return
		putLabel.text += putText.pop_front()
		putLabel.visible = false
		putLabel.visible = true
		inputText.focus_mode = Control.FOCUS_NONE 

#初始化
func start():
	clear_area()
	initStyle()
	initScene()
	bindEvent()

func initStyle():
	myChatStyle                            = StyleBoxFlat.new()
	myChatStyle.bg_color                   = Color("566070")
	myChatStyle.corner_detail              = 8
	myChatStyle.corner_radius_top_left     = 8
	myChatStyle.corner_radius_top_right    = 8
	myChatStyle.corner_radius_bottom_left  = 8
	myChatStyle.corner_radius_bottom_right = 8
	myChatStyle.border_width_left          = 4
	myChatStyle.border_width_top           = 4
	myChatStyle.border_width_right         = 4
	myChatStyle.border_width_bottom        = 4
	myChatStyle.border_color               = Color("566070")

func initScene():
	var area  = ScrollContainer.new()
	inputText = LineEdit.new()
	chatArea  = VBoxContainer.new()
	
	area.add_child(chatArea)
	add_child(area)
	add_child(inputText)
	
	
	#聊天区域
	area.position = Vector2(10,10)
	area.size = Vector2(size.x-20,size.y-60)
	chatArea.alignment = BoxContainer.ALIGNMENT_END
	chatArea.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	chatArea.size_flags_vertical   = Control.SIZE_EXPAND_FILL
	
	inputText.context_menu_enabled = false
	inputText.position = Vector2(10,size.y-40)
	inputText.size     = Vector2(size.x-20,30)
	
	inputText.grab_focus()

func bindEvent():
	inputText.text_submitted.connect(Callable(self,"parsing"))

#清空区域
func clear_area():
	for item in get_children():
		remove_child(item)

#清空聊天
func clear_chat_area():
	for item in chatArea.get_children():
		chatArea.remove_child(item)
	
#解析输出的数据
func parsing(text:String):
	if len(text) <= 0: return
	inputText.text = ""
	if text.begins_with("/"):
		code(text.trim_prefix("/"))
	else:
		create_self_chat(text)
	
#代码解析
func code(code:String):
	match code:
		"r"       : start()
		"reload"  : start()
		"c"       : clear_chat_area()
		"clear"   : clear_chat_area()
		_         : 
			if code.contains("create"):
				songGQCreate.new(code.trim_prefix("create"),self)
			else:
				create_bot_chat("未找到命令")
#创建聊天
func create_bot_chat(content=""):
	var label = create_chat(content,false)
	putText.clear()
	for c in label.text:
		putText.append(c)
	putLabel   = label
	putLabel.text = ""

#创建个人聊天
func create_self_chat(content=""):
	create_chat(content,true)

#创建聊天
func create_chat(content="",is_self=true)->Label:
	var label = Label.new()
	label.text = content
	label.add_theme_stylebox_override("normal",myChatStyle)
	label.add_theme_color_override("font",Color.WHITE)
	if is_self:
		label.size_flags_horizontal = Control.SIZE_SHRINK_END
	else:
		label.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	chatArea.add_child(label)
	label.visible = false
	label.visible = true
	var le = ceil(label.size.x/chatArea.size.x)
	if le <= 1: return label
	var sp = splitStringIntoParts(content,le)
	label.text = ""
	for item in sp:
		label.text += item+"\n"
	label.text = label.text.trim_suffix("\n")
	label.visible = false
	label.visible = true
	return label

#分割字符串
func splitStringIntoParts(input_string: String, num_parts: int) -> Array:
	var result = []
	var total_length = input_string.length()
	var part_length = ceil(total_length / num_parts)

	for i in range(num_parts):
		var start_index = i * part_length
		var end_index = min(start_index + part_length, total_length)
		var part = input_string.substr(start_index, end_index - start_index)
		result.append(part)

	return result

#创建提示
func create_tip():
	pass
