extends ICommand

func execv(path):
	FileAccess.open(path,FileAccess.READ)
