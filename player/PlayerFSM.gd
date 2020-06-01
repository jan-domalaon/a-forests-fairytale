extends StateMachine
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	add_state("idle")
#	add_state("run")
#	add_state("jump")
#	add_state("double_jump")
#	add_state("fall")
#	add_state("knockback")
#	add_state("dead")
#	call_deferred("set_state", states.idle)
#
#
#func handle_input_player():
#	var dir = 0
#	if Input.is_action_pressed("move_right"):
#		dir += 1
#		parent.flip_player_left(false)
#	if Input.is_action_pressed("move_left"):
#		dir -= 1
#		parent.flip_player_left(true)
#
#	if dir != 0:
#		parent.velocity.x = lerp(parent.velocity.x, dir * parent.move_speed, parent.acceleration)
#	else:
#		parent.velocity.x = lerp(parent.velocity.x, 0, parent.friction)
#
#	if state == states.jump:
#		if Input.is_action_just_pressed("jump"):
#			if parent.is_on_floor():
#				parent.handle_jump_animation()
#				parent.velocity.y = parent.jump_speed
#
#	if Input.is_action_just_pressed("spell_cast"):
#		parent.spell_cast()
#
#func _state_logic(delta):
#	parent.handle_input_player()
#	parent.apply_gravity(delta)
#	parent.apply_movement(delta)
#
## Handles transitions of states
#func _get_transition(delta):
#	match state:
#		states.idle:
#			if !parent.is_on_floor():
#				if parent.velocity.y < 0:
#					return states.jump
#				elif parent.velocity.y >= 0:
#					return states.fall
#			elif parent.velocity.x != 0:
#				return states.run
#		states.run:
#			if !parent.is_on_floor():
#				if parent.velocity.y < 0:
#					return states.jump
#				elif parent.velocity.y >= 0:
#					return states.fall
#			elif parent.velocity.x == 0:
#				return states.idle
#		states.jump:
#			if parent.is_on_floor():
#				return states.idle
#			elif parent.velocity.y >= 0:
#				return states.fall
#		states.fall:
#			if parent.is_on_floor():
#				return states.idle
#			elif parent.velocity.y < 0:
#				return states.jump
#	return null
#
#func _enter_state(new_state, old_state):
#	match new_state:
#		states.idle:
#			parent.anim_state_machine.travel("idle")
#		states.run:
#			parent.anim_state_machine.travel("run")
#		states.jump:
#			parent.anim_state_machine.travel('jump')
#
#
#func _exit_state(old_state, new_state):
#	pass
