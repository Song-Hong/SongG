@tool
extends EditorPlugin

var dock

func _enter_tree():
	dock = preload("res://addons/csvsupport/scenes/csvPreview.tscn").instantiate()
	add_control_to_bottom_panel(dock,"CSV Preview")

func clicked():
	print("You clicked me!")

func _exit_tree():
	remove_control_from_bottom_panel(dock)
	dock.free()
