@tool
extends LineEdit
class_name csvsupport_node

var csvPreview:ScrollContainer

func _ready():
	connect("text_changed",Callable(self,"_on_text_changed"))
	csvPreview = $"../../.."

#on text value change
func _on_text_changed(new_text):
	if csvPreview != null:
		csvPreview.on_value_change(name,new_text)
