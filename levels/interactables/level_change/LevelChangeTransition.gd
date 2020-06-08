extends CanvasLayer


func change_level_transition(path, delay=0.5):
	yield(get_tree().create_timer(delay), "timeout")
	$TransitionAnimPlayer.play("fade")
	yield($TransitionAnimPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	$TransitionAnimPlayer.play_backwards("fade")
