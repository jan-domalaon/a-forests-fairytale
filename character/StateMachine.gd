# Abstract class/interface for state machine
# Game Endeavour's tutorial on a state machine
# See https://www.youtube.com/watch?v=BNU8xNRk_oU

extends Node


class_name StateMachine

var state = null setget set_state
var previous_state = null

# Dictionary of all possible states
var states = {}

onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		if transition != null:
			set_state(transition)

#
# Virtual methods (implemented in specific character)
#
# Runs state logic per tick
func _state_logic(delta):
	pass

# Handles transitions of states
func _get_transition(delta):
	return null

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass


#
# Methods for switching states
#
func set_state(new_state):
	previous_state = state
	state = new_state

	if previous_state != null:
		_exit_state(previous_state, new_state)
	if new_state != null:
		_enter_state(new_state, previous_state)

func add_state(state_name):
	# State name has value of the state size currently
	# Gives index to the states
	states[state_name] = states.size()
