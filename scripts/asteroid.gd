class_name Asteroid extends Area2D

enum State{FLOATING, GRABBED, THROWN}

signal exploded(pos, size)

var movement_vector := Vector2(0,-1)
var state = State.FLOATING

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
			sprite.texture = preload("res://assets/sprites/spr_placeholder_asteroid_big.png")
			cshape.shape = preload("res://resources/asteroid_cshape_big.tres")
		AsteroidSize.MEDIUM:
			speed = randf_range(75,125)
			sprite.texture = preload("res://assets/sprites/spr_placeholder_asteroid_medium.png")
			cshape.shape = preload("res://resources/asteroid_cshape_medium.tres")
		AsteroidSize.SMALL:
			speed = randf_range(100,150)
			sprite.texture = preload("res://assets/sprites/spr_placeholder_asteroid_small.png")
			cshape.shape = preload("res://resources/asteroid_cshape_small.tres")
	

func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta

	if grabbed == true && size != AsteroidSize.LARGE && state == State.FLOATING:
		state = State.GRABBED
		self.position = get_node(".../Player").global_position
	elif grabbed == true && size == AsteroidSize.LARGE:
		print("Can't be grabbed!")
		grabbed = false
	
	

## screen wrap
	var screen_size = get_viewport_rect().size
	var radius = cshape.shape.radius
	global_position.x = wrapf(global_position.x,0-radius,screen_size.x+radius)
	global_position.y = wrapf(global_position.y,0-radius,screen_size.y+radius)

## grabbed
func grabinput():
	if Input.is_action_just_pressed("grab_throw"):
		var bodies = cshape.get_overlapping_bodies()
		print(bodies)
		for body in bodies:
			if body.name == "Player" && get_node("../Player").cangrab == true:
				grabbed = true
				get_node("../Player").cangrab == false
				print("Asteroid grabbed...")

## explode
func explode():
	emit_signal("exploded", global_position, size)
	queue_free()
