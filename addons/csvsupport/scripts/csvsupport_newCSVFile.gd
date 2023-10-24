@tool
extends Button

func _ready():
	connect("button_down",Callable(self,"_on_button_down"))

func _on_button_down():
	$"../../IO".save_new_csv()
