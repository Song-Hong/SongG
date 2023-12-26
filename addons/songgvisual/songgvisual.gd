@tool
extends EditorPlugin

#场景路径
const scene_path = "res://addons/songgvisual/scenes/songgvisual.tscn"

#场景
var dock

func _enter_tree():
	dock = preload(scene_path).instantiate()
	EditorInterface.get_editor_main_screen().add_child(dock)

func _exit_tree():
	if dock:
		dock.queue_free()

#是否是主场景插件
func _has_main_screen():
	return true

#设置显示
func _make_visible(visible):
	if dock:
		dock.visible = visible

#插件名称
func _get_plugin_name():
	return "SongGVisual"

#获取主场景插件logo
func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
