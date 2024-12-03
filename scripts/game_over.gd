extends Control

@onready var score = $HighScore:
	set(value):
		score.text = "HIGH SCORE: " + str(SaveLoad.highscore)

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	print("Reset scene.")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
