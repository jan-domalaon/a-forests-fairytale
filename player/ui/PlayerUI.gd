extends CanvasLayer


signal update_healthbar_ui(updated_hp, max_health)

func _ready():
	# Connect UI elements to player's signal
	get_parent().connect("update_health", self, "emit_healthbar_update")


func _process(delta):
	pass


func emit_healthbar_update(health, max_health):
	# Update the player's health bar. Conenct signal in healthbar
	emit_signal("update_healthbar_ui", health, max_health)
