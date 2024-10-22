extends Node2D

@onready var player = $Player
@onready var laser = $LasersTEMP
@onready var asteroids = $Asteroids


var asteroid_scene = preload("res://scenes/asteroid.tscn")

func _ready():
	
	player.connect("died", _on_player_died)
	
	for asteroid in asteroids.get_children():
		asteroid.connect("exploded", _on_asteroid_exploded)
		asteroid.connect("asteroidthrown", _on_asteroid_asteroidthrown)

func _process(delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		print("Reset scene.")
		

func _on_asteroid_exploded(pos, size):
	for i in range(2):
		match size:
			Asteroid.AsteroidSize.LARGE:
				_asteroid_splitspawn(pos, Asteroid.AsteroidSize.MEDIUM)
			Asteroid.AsteroidSize.MEDIUM:
				_asteroid_splitspawn(pos, Asteroid.AsteroidSize.SMALL)
			Asteroid.AsteroidSize.SMALL:
				pass

func _on_asteroid_asteroidthrown():
	player.isholding = false
	player.cangrab = false
	await get_tree().create_timer(0.5).timeout
	player.cangrab = true

func _asteroid_splitspawn(pos, size):
	var a = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded", _on_asteroid_exploded)
	asteroids.call_deferred("add_child", a)
	
func _on_player_died():
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()
	print("Reset scene.")
