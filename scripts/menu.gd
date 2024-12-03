extends Node2D

@onready var highscore = $CanvasLayer/HighScoreTitle

func _ready():
	highscore.text = "HIGH SCORE: " + str(SaveLoad.highscore)

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_instructions_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/instructions.tscn")
