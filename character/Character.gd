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
var is_dead = false

var invincible = false

signal update_health(health, max_health)

#
# CHARACTER ANIMATION STATE MACHINE
#
var anim_state_machine

#
# CHARACTER HEALTH
#
export (int) var max_health = 1
export (int) var health = 1


func _ready():
	health = max_health
	anim_state_machine = $AnimationTree.get("parameters/playback")


func _physics_process(delta):
	apply_gravity(delta)
	apply_movement()


func apply_movement():
	velocity = move_and_slide(velocity, Vector2.UP)


func apply_gravity(delta):
	velocity.y += gravity * delta


func get_damaged(hp_damage):
	# Only get damaged if not invincible
	if not invincible:
		if health - hp_damage <= 0:
			toggle_dead_state()
			
			# TODO: Add a death condition for player and mob
			if is_in_group("Player"):
				pass
			elif is_in_group("Mob"):
				pass
			print(get_name() + " has died!")
		else:
			health -= hp_damage
			emit_signal("update_health", health, max_health)
			
			# Play flicker
			$AnimationPlayer.play("flicker")


func toggle_dead_state():
	is_dead = true
	health = 0
	emit_signal("update_health", health, max_health)


func toggle_invincibility():
	invincible = not invincible
