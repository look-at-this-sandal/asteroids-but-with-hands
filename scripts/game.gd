extends Node2D

@onready var player = $Player
@onready var asteroids = $Asteroids
@onready var hud = $UI/HUD
@onready var gameoverscreen = $UI/GameOverScreen
@onready var pause_menu = $UI/PauseMenu

@onready var explsound = $AsteBreakSound
@onready var diesound = $PlayerDieSound

var asteroid_scene = preload("res://scenes/asteroid.tscn")
var aste_expl_scene = preload("res://scenes/asteroid_explosion.tscn")

var aste_size_array = [Asteroid.AsteroidSize.LARGE,Asteroid.AsteroidSize.LARGE,Asteroid.AsteroidSize.MEDIUM,Asteroid.AsteroidSize.MEDIUM,Asteroid.AsteroidSize.MEDIUM,Asteroid.AsteroidSize.SMALL]
var lowonasteroids = false

var score := 0:
	set(value):
		score = value
		hud.score = score
		gameoverscreen.score = SaveLoad.highscore

func _ready():
	score = 0
	player.connect("died", _on_player_died)
	
	for asteroid in asteroids.get_children():
		asteroid.connect("exploded", _on_asteroid_exploded)
		## asteroid.connect("asteroidthrown", _on_asteroid_asteroidthrown) OLD SCRIPT!!!!
	
	var asteroidgroup = get_tree().get_nodes_in_group("Asteroids")
	print(asteroidgroup)

func _process(delta):
	## if Input.is_action_just_pressed("reset"):
		## get_tree().reload_current_scene()
		## print("Reset scene.")
		
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		pauseMenu()
	if get_tree().get_nodes_in_group("Asteroids").size() <= 2 && lowonasteroids == false: 
		_spawn_wave()
		lowonasteroids = true
	


func pauseMenu():
	if get_tree().paused == true: pause_menu.visible = true
	else: pause_menu.visible = false

func _on_asteroid_exploded(pos, size, points):
	var explod_a = aste_expl_scene.instantiate()
	explsound.play()
	add_child(explod_a)
	explod_a.global_position = pos
	score += points
	
	for i in range(2):
		match size:
			Asteroid.AsteroidSize.LARGE:
				_asteroid_splitspawn(pos, Asteroid.AsteroidSize.MEDIUM)
			Asteroid.AsteroidSize.MEDIUM:
				_asteroid_splitspawn(pos, Asteroid.AsteroidSize.SMALL)
			Asteroid.AsteroidSize.SMALL:
				pass
	
	if score > SaveLoad.highscore:
		SaveLoad.highscore = score
		SaveLoad.save_score()

## func _on_asteroid_asteroidthrown(): OLD SCRIPT!!!!
	## print("Asteroid Thrown signal")
	## player.isholding = false
	## player.cangrab = false
	## await get_tree().create_timer(0.5).timeout
	## player.cangrab = true

func _asteroid_wavespawn(pos,size,state):
	var new_a = asteroid_scene.instantiate()
	new_a.global_position = pos
	new_a.size = size
	new_a.state = state
	new_a.connect("exploded", _on_asteroid_exploded)
	asteroids.call_deferred("add_child", new_a)

func _asteroid_splitspawn(pos, size):
	var a = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded", _on_asteroid_exploded)
	asteroids.call_deferred("add_child", a)
	
func _on_player_died():
	diesound.play()
	await get_tree().create_timer(1).timeout
	gameoverscreen.visible = true

func _spawn_wave():
	var screen_size = get_viewport().get_visible_rect().size
	print("Less than or equal to two asteroids!")
	await get_tree().create_timer(2).timeout
	for i in aste_size_array:
		await get_tree().create_timer(0.1).timeout
		_asteroid_wavespawn(Vector2((randi_range(0, screen_size.x)),-64),i,Asteroid.State.SPAWNING)
	lowonasteroids = false
	pass
