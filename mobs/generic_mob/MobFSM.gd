extends StateMachine


func _state_logic(delta):
	add_state("idle")
	add_state("wander")
	add_state("chase")
	add_state("dead")
	call_deferred("set_state", states.idle)

# Handles transitions of states
func _get_transition(delta):
	return null

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
