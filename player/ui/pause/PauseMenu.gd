extends CanvasLayer


var game_paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	handle_pause_input()


func handle_pause_input():
	if Input.is_action_just_pressed("pause_menu"):
		toggle_pause()


func toggle_pause():
	toggle_ui_elements()
	get_tree().paused = !game_paused
	game_paused = !game_paused


func _on_Quit_pressed():
	get_tree().quit()


func _on_Resume_pressed():
	toggle_pause()


func toggle_ui_elements():
	$ColorRect.visible = !game_paused
	$CenterContainer.visible = !game_paused
