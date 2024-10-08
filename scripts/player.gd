extends CharacterBody2D

## movement
@export var acceleration := 14.0
@export var max_speed := 300
@export var turn_speed := 200.0

func _process(delta):
	pass

func _physics_process(delta):
	
	var input_vector := Vector2(0, Input.get_axis("move_forward", "move_backward"))
	
	velocity += input_vector.rotated(rotation) * acceleration
	velocity = velocity.limit_length(max_speed)
	
	if Input.is_action_pressed("turn_right"):
		rotate(deg_to_rad(turn_speed*delta))
	if Input.is_action_pressed("turn_left"):
		rotate(deg_to_rad(-turn_speed*delta))
	
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 5)
	
	move_and_slide()
	
	## screen wrap
	var screen_size = get_viewport_rect().size
	var height = $CollisionShape2D.shape.height
	# when re-using these for the asteroid screen loop, make sure to call the shape's radius instead of height
	global_position.x = wrapf(global_position.x,0-height,screen_size.x+(height/2))
	global_position.y = wrapf(global_position.y,0-height,screen_size.y+(height/2))
	
