extends Node2D

@onready var player = $Player
@onready var asteroids = $Asteroids
@onready var hud = $UI/HUD
@onready var gameoverscreen = $UI/GameOverScreen
@onready var pause_menu = $UI/PauseMenu

var asteroid_scene = preload("res://scenes/asteroid.tscn")

var asteroid_highcount = 5

var score := 0:
	set(value):
		score = value
		hud.score = score

func _ready():
	score = 0
	player.connect("died", _on_player_died)
	
	for asteroid in asteroids.get_children():
		asteroid.connect("exploded", _on_asteroid_exploded)
		## asteroid.connect("asteroidthrown", _on_asteroid_asteroidthrown) OLD SCRIPT!!!!

func _process(delta):
	## if Input.is_action_just_pressed("reset"):
		## get_tree().reload_current_scene()
		## print("Reset scene.")
		
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		pauseMenu()
	


func pauseMenu():
	if get_tree().paused == true: pause_menu.visible = true
	else: pause_menu.visible = false

func _on_asteroid_exploded(pos, size, points):
	score += points
	for i in range(2):
		match size:
			Asteroid.AsteroidSize.LARGE:
				_asteroid_splitspawn(pos, Asteroid.AsteroidSize.MEDIUM)
			Asteroid.AsteroidSize.MEDIUM:
				_asteroid_splitspawn(pos, Asteroid.AsteroidSize.SMALL)
			Asteroid.AsteroidSize.SMALL:
				pass

## func _on_asteroid_asteroidthrown(): OLD SCRIPT!!!!
	## print("Asteroid Thrown signal")
	## player.isholding = false
	## player.cangrab = false
	## await get_tree().create_timer(0.5).timeout
	## player.cangrab = true

func _asteroid_splitspawn(pos, size):
	var a = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded", _on_asteroid_exploded)
	asteroids.call_deferred("add_child", a)
	
func _on_player_died():
	await get_tree().create_timer(1).timeout
	gameoverscreen.visible = true

func _spawn_wave():
	## count how many asteroid nodes are on screen
	## determine of the number is less than two
	## spawn new asteroids of random sizes in random places
	pass
