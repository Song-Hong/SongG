extends IMoudle
class_name Core

func _ready():
	Process.init.change_process(SongGProcess.new())
