extends CanvasLayer




func _on_QuitButton_pressed():
	get_tree().quit()


func _on_PlayButton_pressed():
	$LevelChangeTransition.set_layer(3)
	LevelChangeTransition.change_level_transition("res://levels/intro/LevelIntro.tscn")
