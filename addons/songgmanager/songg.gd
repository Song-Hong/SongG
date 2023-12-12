@tool
extends EditorPlugin

var dock

func _enter_tree():
	dock = preload("res://addons/songgmanager/Scenes/SongGManager.tscn").instantiate()
	EditorInterface.get_editor_main_screen().add_child(dock)

func _exit_tree():
	if dock:
		dock.queue_free()

#是否时主场景插件
func _has_main_screen():
	return true

#设置显示
func _make_visible(visible):
	if dock:
		dock.visible = visible

#插件名称
func _get_plugin_name():
	return "SongG"

#获取主场景插件logo
func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
