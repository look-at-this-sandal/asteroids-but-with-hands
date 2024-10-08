class_name Claw extends Area2D

enum State { FIRING, ACTIVE_WAIT, RETRACTING }

var holding = false
var movement_vector = Vector2(0,-2)
var speed = 200
var thingy
var state
var player

func _ready():
	player = get_parent()
	print(player)
	state = State.FIRING
	visible = true
	

func _process(delta):
	if state == State.FIRING:
		pass

func _physics_process(delta):
	if state == State.FIRING:
		pass
