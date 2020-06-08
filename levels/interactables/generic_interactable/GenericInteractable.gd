extends Area2D

export (String) var label_text = ""


func _ready():
	$Label.text = label_text


func _on_GenericInteractable_body_entered(body):
	# Show text only when the player walks up
	if (body.is_in_group("Player")):
		$AnimationPlayer.play("show_text")


func _on_GenericInteractable_body_exited(body):
	# play text animation in reverse
	if (body.is_in_group("Player")):
		$AnimationPlayer.play_backwards("show_text")
