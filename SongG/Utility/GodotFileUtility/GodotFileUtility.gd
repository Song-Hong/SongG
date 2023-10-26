extends IUtility
class_name GodotFileUtility

var commands:Dictionary

func _init():
	commands["read"]  = GodotFileUtility_ReadCommand.new()
	commands["readA"] = GodotFileUtility_ReadCommand.new()
	commands["save"]  = GodotFileUtility_SaveCommand.new()
	commands["saveA"] = GodotFileUtility_ReadCommand.new()

func read(path): return commands["read"].execv(path)

func read_async(path): commands["readA"].execv(path)

func save(path,content): commands["save"].execv(path,content)

func save_async(path): commands["saveA"].execv(path)
