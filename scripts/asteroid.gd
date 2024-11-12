class_name Asteroid extends Area2D

enum State {FLOATING, GRABBED, THROWN, GRABBING}

signal exploded(pos, size, points)

var movement_vector := Vector2(0,-1)
var state = State.FLOATING
var max_speed = 0

enum AsteroidSize{LARGE, MEDIUM, SMALL}
@export var size := AsteroidSize.LARGE

@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

var speed = 0
var player

var grabbed = false

var points: int:
	get:
		match size:
			AsteroidSize.LARGE:
				return 100
			AsteroidSize.MEDIUM:
				return 50
			AsteroidSize.SMALL:
				return 25
			_:
				return 0


func _ready():
	rotation = randf_range(0, 2*PI)
	player = get_tree().get_nodes_in_group("Player")[0]
	match size:
		AsteroidSize.LARGE:
			speed = randf_range(50,100)
			max_speed = 100
			sprite.texture = preload("res://assets/sprites/spr_placeholder_asteroid_big.png")
			cshape.shape = preload("res://resources/asteroid_cshape_big.tres")
		AsteroidSize.MEDIUM:
			speed = randf_range(75,125)
			max_speed = 125
			sprite.texture = preload("res://assets/sprites/spr_placeholder_asteroid_medium.png")
			cshape.shape = preload("res://resources/asteroid_cshape_medium.tres")
		AsteroidSize.SMALL:
			speed = randf_range(100,150)
			max_speed = 150
			sprite.texture = preload("res://assets/sprites/spr_placeholder_asteroid_small.png")
			cshape.shape = preload("res://resources/asteroid_cshape_small.tres")
	

func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta

## grab size check
	if grabbed == true && size != AsteroidSize.LARGE && state == State.FLOATING:
		state_transition(State.FLOATING, State.GRABBING)
		## await get_tree().create_timer(1).timeout
		reparent(player)
		var tween = create_tween()
		tween.tween_property(self,"position",Vector2(),0.1)
		await tween.finished
		state_transition(State.GRABBING, State.GRABBED)
	elif grabbed == true && size == AsteroidSize.LARGE:
		print("Can't be grabbed!")
		grabbed = false
	

## screen wrap
	var screen_size = get_viewport_rect().size
	var radius = cshape.shape.radius
	global_position.x = wrapf(global_position.x,0-radius,screen_size.x+radius)
	global_position.y = wrapf(global_position.y,0-radius,screen_size.y+radius)


## state machine
	if state == State.GRABBING:
		rotation = 0
		pass
		
	elif state == State.GRABBED:
		speed = 0
		## rotation = get_node("/root/Game/Player").rotation   commented out for now
		## global_position = get_node("/root/Game/Player").global_position   commented out for now
		# add timer in code, don't change rotation and don't snap position
		# use a tween
		## if Input.is_action_just_pressed("grab_throw"): OLD SCRIPT!!!!
				## throwing()
				## state_transition(State.GRABBED, State.THROWN)
				
			
	elif state == State.THROWN:
		speed = 600
		await get_tree().create_timer(1).timeout
		state_transition(State.THROWN, State.FLOATING)
		
	elif state == State.FLOATING:
		if speed > max_speed:
			speed = lerpf(speed, max_speed, delta*2)
## explode
func explode():
	emit_signal("exploded", global_position, size, points)
	queue_free()
## grabbed
func grabbing():
	grabbed = true
	print("Asteroid grabbed...")
## thrown
func throwing():
	grabbed = false
	reparent(get_node("/root/Game/Asteroids"))
	print("Asteroid thrown!")

## asteroid collision
func _on_area_entered(area):
	if area is Asteroid:
		if state == State.THROWN:
			var a = area
			a.explode()
			explode()
	

## state machine transition
func state_transition(prev_state: State, next_state: State) -> void:
	state = next_state
	

## player ship collision
func _on_body_entered(body) -> void:
	if body is Player:
		var playership = body
		if self.state == State.FLOATING || (self.state == State.THROWN && playership.cangrab == true):
			print("The player has died!")
			playership.die()
