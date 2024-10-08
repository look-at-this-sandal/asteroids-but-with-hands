extends Area2D

enum State { INACTIVE, FIRING, ACTIVE_WAIT, RETRACTING }

var claw_cd = false
var can_shoot = true
var holding = false
var speed = 300
var state
var player

func _ready():
	player = get_parent()
	print(player)
	state = State.INACTIVE
	visible = false
	

@warning_ignore("unused_parameter")
func _process(delta):
	if state == State.INACTIVE:
		
		if (can_shoot == true) && Input.is_action_just_pressed("grab_throw"):
			state = State.FIRING
			print("Just shot out the claw!")
			can_shoot = false
	
	if state == State.FIRING:
		visible = true
		
		

func _physics_process(delta):
	pass
