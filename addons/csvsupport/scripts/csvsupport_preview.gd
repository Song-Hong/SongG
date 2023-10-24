@tool
extends ScrollContainer

@export var area:VBoxContainer

var now_data:csvsupport_csvdata

func _ready():
	now_data = csvsupport_csvdata.new()
	show_csv()

func show_csv():
	var col = $col
	for child in col.get_children():
		col.remove_child(child)
	if now_data.max_x < 4 || now_data.max_y < 4:
		for i in range(4):
			now_data.add_row(i,["","","",""])
	
	var frist_l = create_line()
	frist_l.add_child(create_lable("   "))
	for x in range(now_data.max_y):
		var content = str(x+1)
		frist_l.add_child(create_lable(str(content),true))
	
	for x in range(now_data.max_x):
		var l = create_line()
		l.add_child(create_lable(str(x+1)+" "))
		for y in range(now_data.max_y):
			l.add_child(create_node(str(x)+","+str(y),now_data.get_value(x,y)))
			
	
	var line_c = col.get_child(1)
	var btn_c  = create_add_btn()
	btn_c.connect("button_down",Callable(self,"add_col"))
	line_c.add_child(btn_c)
	
	var line_r = create_line()
	var btn_r  = create_add_btn()
	btn_r.connect("button_down",Callable(self,"add_row"))
	line_r.add_child(create_lable("   "))
	line_r.add_child(btn_r)

func create_add_btn()->Button:
	var btn = Button.new()
	btn.text = "+"
	btn.custom_minimum_size = Vector2(31,31)
	return btn

func add_row():
	var data = []
	for i in range(now_data.max_y):
		data.append("")
	now_data.add_row(now_data.max_x,data)
	show_csv()

func add_col():
	var list = []
	for i in range(now_data.max_x+1):
		list.append("")
	now_data.add_col(now_data.max_y,list)
	show_csv()

#创建显示节点
func create_lable(content,is_top=false)->Label:
	var label = Label.new()
	label.text = content
	if is_top:
		label.custom_minimum_size = Vector2(67,31)
	else:
		label.custom_minimum_size = Vector2(31,31)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment   = VERTICAL_ALIGNMENT_CENTER
	return label

#创建行
func create_line()->HBoxContainer:
	var line = HBoxContainer.new()
	area.add_child(line)
	return line

#创建输入节点
func create_node(node_name:String,content = "")->LineEdit:
	var edit = LineEdit.new()
	edit.text = content
	edit.name = node_name
	edit.set_script(csvsupport_node)
	return edit

func on_value_change(node_name:String,value:String):
	var po = node_name.split(",")
	var x  = int(po[0])
	var y  = int(po[1])
	now_data.set_value(x,y,value)

func save():
	$"../IO".save_as_csv(now_data)
