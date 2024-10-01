extends Area2D

var movement_vector := Vector2(0,-1)

enum AsteroidSize{LARGE, MEDIUM, SMALL}
@export var size := AsteroidSize.LARGE

var speed = 0

func _ready():
	rotation = randf_range(0, 2*PI)
	print(rotation_degrees)
	
	match size:
		AsteroidSize.LARGE:
			speed = randf_range(50,100)
		AsteroidSize.MEDIUM:
			speed = randf_range(75,125)
		AsteroidSize.SMALL:
			speed = randf_range(100,150)
	
	print(speed)

func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta

## screen wrap
	var screen_size = get_viewport_rect().size
	var radius = $CollisionShape2D.shape.radius
	global_position.x = wrapf(global_position.x,0-radius,screen_size.x+radius)
	global_position.y = wrapf(global_position.y,0-radius,screen_size.y+radius)
