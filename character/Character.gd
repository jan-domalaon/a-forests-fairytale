extends KinematicBody2D

#
# MOVEMENT VARIABLES
#
export (int) var move_speed = 300
export (int) var jump_speed = -600
export (int) var gravity 	= 3000

export (float, 0, 1.0) var acceleration = 0.25
export (float, 0, 1.0) var friction = 0.1

var velocity = Vector2.ZERO

#
# CHARACTER ANIMATION STATE MACHINE
#
var state_machine

#
# CHARACTER HEALTH
#
export (int) var health = 1


func _ready():
	state_machine = $AnimationTree.get("parameters/playback")


func _physics_process(delta):
	velocity_movement(delta)

func velocity_movement(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
