extends Node


export (bool) var debug_mode = false
export (bool) var beginning_level = false
export (bool) var terminal_level = false
export (bool) var level_timer_on = false
export (int) var level_timer_duration = 10
export (bool) var hide_ui = false
export (Color) var background_color
export (Dictionary) var level_collectibles = {"white": false,
											"blue": false,
											"red": false}


signal hide_ui
signal update_time(seconds)

func _ready():
	# Change background color
	VisualServer.set_default_clear_color(background_color)
	
	# Hide player UI if needed
	if hide_ui:
		emit_signal("hide_ui")
	
	# Set level timer
	$LevelTimer.wait_time = level_timer_duration
	emit_signal("update_time", $LevelTimer.wait_time)
	
	# Connect to level start triggers if this level has a level timer trigger
	if has_node("StartTimer/LevelTimerTrigger"):
		print("timer started!")
		$StartTimer/LevelTimerTrigger.connect("start_level_timer", self, "on_start_level_timer")


func _process(delta):
	# Show timer time on player's UI
	if level_timer_on:
		emit_signal("update_time", int($LevelTimer.get_time_left()))


func on_start_level_timer():
	level_timer_on = true
	$LevelTimer.start()


func _on_LevelTimer_timeout():
	# Trigger game over state for player
	if has_node("Player"):
		$Player.set_game_over(true)
		$Player.handle_game_over()
