extends HBoxContainer

var healthbar_spritesheet = preload("res://player/ui/health/health_bar_atlas.tres")

const FULL_BAR = 		Rect2(0, 0, 65, 16)
const TWO_THIRD_BAR = 	Rect2(0, 16, 65, 16)
const ONE_THIRD_BAR = 	Rect2(0, 32, 65, 16)
const EMPTY_BAR = 		Rect2(0, 64, 65, 16)

onready var healthbar = $HealthBar


func _ready():
	# Connect to PlayerUI
	get_parent().get_owner().connect("update_healthbar_ui", self, "update_healthbar_texture")
	
	# Get player's health
	pass


func update_healthbar_texture(current_health, max_health):
	healthbar.texture = healthbar_spritesheet
	healthbar_spritesheet.region = FULL_BAR
	if current_health < max_health * 0.66:
		healthbar_spritesheet.region = TWO_THIRD_BAR
	if current_health < max_health * 0.33:
		healthbar_spritesheet.region = ONE_THIRD_BAR
	if current_health < max_health * 0.01:
		healthbar_spritesheet.region = EMPTY_BAR
