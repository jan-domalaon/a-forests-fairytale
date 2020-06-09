extends Node


export (bool) var debug_mode = false
export (bool) var beginning_level = false
export (bool) var terminal_level = false
export (bool) var toggle_hud_for_player = false
export (bool) var level_timer = false
export (bool) var hide_ui = false
export (Color) var background_color
export (Dictionary) var level_collectibles = {"white": false,
											"blue": false,
											"red": false}


signal hide_ui

func _ready():
	# Change background color
	VisualServer.set_default_clear_color(background_color)
	
	# Place player at PlayerStart
	pass
	
	# Hide player UI if needed
	if hide_ui:
		emit_signal("hide_ui")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
