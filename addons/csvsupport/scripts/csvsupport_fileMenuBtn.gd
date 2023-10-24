@tool
extends Button

@export var filePanel:Panel

func _ready():
	connect("button_down",Callable(self,"_on_button_down"))
	
func _on_button_down():
	filePanel.visible = !filePanel.visible

