extends Node


export (bool) var debug_mode = false
export (bool) var beginning_level = false
export (bool) var terminal_level = false
export (Color) var background_color


func _ready():
	# Change background color
	VisualServer.set_default_clear_color(background_color)
	
	# Place player at PlayerStart
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
