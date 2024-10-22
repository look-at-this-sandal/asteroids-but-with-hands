class_name Asteroid extends Area2D

enum State {FLOATING, GRABBED, THROWN}

signal exploded(pos, size)
signal asteroidthrown

var movement_vector := Vector2(0,-1)
var state = State.FLOATING
var max_speed = 0

enum AsteroidSize{LARGE, MEDIUM, SMALL}
@export var size := AsteroidSize.LARGE

@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

var speed = 0

var grabbed = false

func _ready():
	rotation = randf_range(0, 2*PI)
	
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
		state_transition(State.FLOATING, State.GRABBED)
		
	elif grabbed == true && size == AsteroidSize.LARGE:
		print("Can't be grabbed!")
		grabbed = false
	

## screen wrap
	var screen_size = get_viewport_rect().size
	var radius = cshape.shape.radius
	global_position.x = wrapf(global_position.x,0-radius,screen_size.x+radius)
	global_position.y = wrapf(global_position.y,0-radius,screen_size.y+radius)

	if state == State.GRABBED:
		speed = 0
		rotation = get_node("/root/Game/Player").rotation
		global_position = get_node("/root/Game/Player").global_position
		
		if Input.is_action_just_pressed("grab_throw"):
				throwing()
				state_transition(State.GRABBED, State.THROWN)
				
			
	elif state == State.THROWN:
		speed = 600
		await get_tree().create_timer(0.5).timeout
		state_transition(State.THROWN, State.FLOATING)
	elif state == State.FLOATING:
		if speed > max_speed:
			speed = lerpf(speed, max_speed, delta)
## explode
func explode():
	emit_signal("exploded", global_position, size)
	queue_free()
## grabbed
func grabbing():
	grabbed = true
	print("Asteroid grabbed...")
## thrown
func throwing():
	grabbed = false
	emit_signal("asteroidthrown")
	print("Asteroid thrown!")
## state machine transition
func state_transition(prev_state: State, next_state: State) -> void:
	state = next_state
	
