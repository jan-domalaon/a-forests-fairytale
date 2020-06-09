extends Camera2D


func _on_Player_grounded_update(is_grounded):
	# Change drag margin such that camera doesn't move when
	# falling or jumping
	drag_margin_v_enabled = not is_grounded
