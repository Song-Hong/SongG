extends ICommand
class_name GodotFileUtility_ReadCommand

func execv(path):
	var file = FileAccess.open(path,FileAccess.READ)
	return file.get_as_text()
