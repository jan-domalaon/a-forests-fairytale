extends Area2D


var started = false

signal start_level_timer

func _on_LevelTimerTrigger_body_entered(body):
	if not started and body.is_in_group("Player"):
		$AnimationPlayer.play("instant_show_text")
		started = true
		emit_signal("start_level_timer")
		print("leveltimertriggered played animation!")
