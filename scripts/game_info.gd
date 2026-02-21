extends Node

const SAVE_PATH := "user://game_info.json"
var day_count: int = 1

func _ready():
	load_game()


func increment():
	day_count+=1
	save_game()
#	money_changed.emit(money) # Tell everyone the money changed!
	
func save_game():
	var data = {
		"day_count": day_count,
		}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))


func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	var data = JSON.parse_string(json_string)
	
	if data == null:
		printerr("Failed to parse save file.")
		return

	# Simple variables (int, float, bool) work fine with '='
	day_count = data.get("day_count", 1)
	