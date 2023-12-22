@tool
extends EditorPlugin

var dock

#
func _enter_tree():
	dock = Control.new()
	dock.name = "SongGQ"
	dock.set_script(load("res://addons/songgq/songQChat.gd"))
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UR,dock)

#退出时执行
func _exit_tree():
	if dock:
		remove_control_from_docks(dock)
		dock.free()
