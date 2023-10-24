@tool
extends Panel
class_name fileMenuChooseBtn

@export var btns  = []
@export var pages = []

var now_page = null

func _ready():
	get_node(btns[0]).connect("mouse_entered",Callable(self,"new_file"))
	get_node(btns[1]).connect("mouse_entered",Callable(self,"open_file"))
	get_node(btns[2]).connect("mouse_entered",Callable(self,"save_file"))
	get_node(btns[3]).connect("mouse_entered",Callable(self,"save_as_file"))
	
	connect("visibility_changed",Callable(self,"_on_visibility_changed"))

func _on_visibility_changed():
	if !visible && now_page != null:
		now_page.visible = false

func new_file():
	if now_page != null: now_page.visible =false
	var page = get_node(pages[0])
	page.visible = true
	now_page = page

func open_file():
	if now_page != null: now_page.visible =false

func save_file():
	if now_page != null: now_page.visible =false
	$"../csvPreview".save()

func save_as_file():
	if now_page != null: now_page.visible =false
