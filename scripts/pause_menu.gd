extends Control

@onready var main = $"../../"

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	

func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false
