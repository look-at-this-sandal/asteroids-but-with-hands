extends Node

const SAVEFILE = "user://savefile.save"

var highscore = 0

func _ready():
	load_score()

func save_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE_READ)
	file.store_32(highscore)
	pass

func load_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if FileAccess.file_exists(SAVEFILE):
		highscore = file.get_32()
	pass
