class_name Player extends CharacterBody2D

signal died

signal highlight

## variable setup

var cangrab = true
var isholding = false
var whatamiholding = 0
var vulnerable = true

@export var acceleration := 14.0
@export var max_speed := 300
@export var turn_speed := 200.0

@onready var autothrowtimer = $AutoGrabTimer
@onready var sprite = $AnimatedSprite2D
@onready var cshape = $CollisionShape2D
@onready var grabraycast = $RayCast2D
@onready var grabsound = $"../GrabSound"
@onready var throwsound = $"../ThrowSound"
@onready var movesound = $"../ThrusterSound"

var alive := true

var explod_scene = preload("res://scenes/player_ship_explosion.tscn")

func _process(delta):
	if !alive: return
	## grabbing and throwing
	
	if grabraycast.is_colliding() && cangrab == true && isholding == false:
		var areas = grabraycast.get_collider()
		if alive: highlight.emit(areas)
		if Input.is_action_just_pressed("grab_throw"):
			if areas is Asteroid:
				var astero = areas
				whatamiholding = astero
				astero.grabbing()
				if astero.size > 0 && astero.state == 0: 
					isholding = true
					sprite.play("grabbing")
					grabsound.play()
			
			cangrab = false
			print("can't grab right now")
			await get_tree().create_timer(1.5).timeout
			if isholding == true: autothrowtimer.start()
			cangrab = true
			if isholding != true: 
				print("can grab again")
			else: 
				print("holding asteroid")
		
	else: highlight.emit(null)
		
	if isholding == true && cangrab == true && (Input.is_action_just_pressed("grab_throw") || autothrowtimer.is_stopped()):
			if is_instance_valid(whatamiholding):
				whatamiholding.throwing()
				whatamiholding.state_transition(1, 2)
			isholding = false
			cangrab = false
			sprite.play("throw")
			throwsound.play()
			await get_tree().create_timer(0.2).timeout
			whatamiholding = 0
			cangrab = true

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "throw": sprite.play("default")

func _physics_process(delta):
	if !alive: return
	## movement
	
	var input_vector := Vector2(0, Input.get_axis("move_forward", "move_backward"))
	
	velocity += input_vector.rotated(rotation) * acceleration
	velocity = velocity.limit_length(max_speed)
	
	if Input.is_action_pressed("turn_right"):
		rotate(deg_to_rad(turn_speed*delta))
	if Input.is_action_pressed("turn_left"):
		rotate(deg_to_rad(-turn_speed*delta))
	
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 5)
	
	if (Input.is_action_pressed("move_forward") ||Input.is_action_pressed("move_backward")) && alive:
		if not movesound.is_playing():
			movesound.play()
	else: movesound.stop()
	
	move_and_slide()
	
	## screen wrap
	var screen_size = get_viewport_rect().size
	var height = $CollisionShape2D.shape.height
	# when re-using these for the asteroid screen loop, make sure to call the shape's radius instead of height
	global_position.x = wrapf(global_position.x,0-height,screen_size.x+(height/2))
	global_position.y = wrapf(global_position.y,0-height,screen_size.y+(height/2))
	

## dying

func die():
	if alive == true:
		alive = false
		sprite.visible = false
		cshape.set_deferred("disabled", true)
		grabraycast.set_deferred("enabled", false)
		var explod_p = explod_scene.instantiate()
		emit_signal("died")
		add_child(explod_p)
		if isholding == true:
			whatamiholding.explode()
			isholding = false
			cangrab = false
		if movesound.is_playing(): movesound.stop()
