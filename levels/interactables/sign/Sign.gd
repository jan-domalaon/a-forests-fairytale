extends Area2D

export (String) var sign_text = ""


func _ready():
	set_sign_text(sign_text)


func _on_Sign_body_entered(body):
	# Show text only when the player walks up
	if (body.is_in_group("Player")):
		$AnimationPlayer.play("type_text")


func _on_Sign_body_exited(body):
	# play text animation in reverse
	if (body.is_in_group("Player")):
		$AnimationPlayer.play_backwards("type_text")


func set_sign_text(text):
	# Get typing text animation
	var text_anim = $AnimationPlayer.get_animation("type_text")
	# Get track to be modified for key value change
	var label_text_track = text_anim.find_track("Label:text")
	text_anim.track_set_key_value(label_text_track, 1, text)
