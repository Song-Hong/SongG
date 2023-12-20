@tool
extends AState
class_name SongG_UM_Init

var area
var zoom

#数据
var data

#初始化
func start():
	load_config()
	init_scene()

func update(_delta):
	pass

func load_config():
	var f = FileAccess.open("res://SongG/Config/Universal.json",FileAccess.READ)
	data  = JSON.parse_string(f.get_as_text())

func init_scene():
	area = own().area
	zoom = own().zoom
	
	#添加logo
	var logotex              = load("res://SongG/Others/Logo/Logo.svg")
	var logo                 = TextureRect.new()
	logo.texture             = logotex
	logo.expand_mode         = TextureRect.EXPAND_IGNORE_SIZE
	logo.custom_minimum_size = Vector2(80,80) * zoom
	var logo_margin          = MarginContainer.new()
	logo_margin.add_child(logo)
	logo_margin.add_theme_constant_override("margin_left" , 30*zoom)
	logo_margin.add_theme_constant_override("margin_top"  , 30*zoom)
	
	#显示名称
	var logo_name_bg               = bgPanel()
	var logo_name                  = Label.new()
	logo_name.text                 = "SongG"
	logo_name.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	logo_name.vertical_alignment   = VERTICAL_ALIGNMENT_CENTER
	var logo_name_margin           = MarginContainer.new()
	logo_name_bg.add_child(logo_name)
	logo_name_margin.add_child(logo_name_bg)
	logo_name_margin.add_theme_constant_override("margin_left" , 120*zoom)
	logo_name_margin.add_theme_constant_override("margin_top"  , 40*zoom)
	logo_name_bg.custom_minimum_size = Vector2(100,30)
	logo_name.custom_minimum_size    = Vector2(100,30)
	logo_name.add_theme_font_size_override("font_size",16)
	logo_name.add_theme_color_override("font_color",Color.WHITE)
	
	#显示版本号
	var logo_version_bg               = bgPanel()
	var logo_version                  = Label.new()
	logo_version.text                 = data["Version"]
	logo_version.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	logo_version.vertical_alignment   = VERTICAL_ALIGNMENT_CENTER
	var logo_version_margin           = MarginContainer.new()
	logo_version_bg.add_child(logo_version)
	logo_version_margin.add_child(logo_version_bg)
	logo_version_margin.add_theme_constant_override("margin_left" , 120*zoom)
	logo_version_margin.add_theme_constant_override("margin_top"  , 75*zoom)
	logo_version_bg.custom_minimum_size = Vector2(100,30)
	logo_version.custom_minimum_size    = Vector2(100,30)
	logo_version.add_theme_font_size_override("font_size",16)
	logo_version.add_theme_color_override("font_color",Color.WHITE)
	
	area.add_child(logo_margin)
	area.add_child(logo_name_margin)
	area.add_child(logo_version_margin)

#背景面板
func bgPanel() -> Panel:
	var bg                           = Panel.new()
	var style                        = StyleBoxFlat.new()
	style.corner_detail              = 8
	style.bg_color                   = Color("252b35")
	style.corner_radius_top_left     = 16
	style.corner_radius_top_right    = 16
	style.corner_radius_bottom_left  = 16
	style.corner_radius_bottom_right = 16
	bg.add_theme_stylebox_override("panel",style)
	return bg
