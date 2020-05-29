extends CanvasLayer


func _ready():
	# Connect UI elements to player's signal
	get_parent().connect("update_health", self, "update_health_bar")


func _process(delta):
	pass


func update_health_bar(health):
	# Update the player's health bar
	$PlayerHealthBar.update_healthbar_ui(health)
