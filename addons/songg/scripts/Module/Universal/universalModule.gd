##
# de_zh  : 全局模块
# author : HongSong
# time   : 2023/12/28 18:11
##
@tool
extends Control

#黑板数据
var data

#初始化
func _ready():
	data = BlackboardData.new()
	universalModuleInitCommand.new(self,data).start()

#初始化框架
func init_songg():
	universalModuleInitSongGCommand.new(self,data).start()

func create_card(title:String,content:String,cancel_text:String,agree_text:String):
	var card = load("res://addons/songg/scenes/card.tscn").instantiate()
	var c_area = card.get_child(0).get_child(0)
	c_area.get_child(0).text = title
	c_area.get_child(1).text = content
	c_area.get_child(2).get_child(0).text = cancel_text
	c_area.get_child(2).get_child(1).text = agree_text
	add_child(card)
	var po = card.position
	card.position = Vector2(size.x,po.y)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(tween.TRANS_QUINT)
	tween.tween_property(card,"position",po,0.4)
