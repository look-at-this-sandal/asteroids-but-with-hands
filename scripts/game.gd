extends Node2D


func _process(delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		print("Reset scene.")
