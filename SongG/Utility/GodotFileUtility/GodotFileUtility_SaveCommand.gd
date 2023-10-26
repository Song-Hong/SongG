extends Node
class_name GodotFileUtility_SaveCommand

func execv(path,content):
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(content)
	
