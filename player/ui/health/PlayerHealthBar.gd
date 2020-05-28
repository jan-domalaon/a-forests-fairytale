extends HBoxContainer

var healthbar_spritesheet = preload("res://player/ui/health/health_bar_atlas.tres")

const FULL_BAR = 		Rect2(0, 0, 65, 16)
const TWO_THIRD_BAR = 	Rect2(0, 16, 65, 16)
const ONE_THIRD_BAR = 	Rect2(0, 32, 65, 16)
const EMPTY_BAR = 		Rect2(0, 64, 65, 16)

onready var healthbar = $HealthBar


func _ready():
	# Get player's health
	pass


func update_healthbar_ui(value):
	healthbar.texture_progress = healthbar_spritesheet
	healthbar_spritesheet.margin = FULL_BAR
	if value < healthbar.max_value * 0.66:
		healthbar_spritesheet.margin = TWO_THIRD_BAR
	if value < healthbar.max_value * 0.33:
		healthbar_spritesheet.margin = ONE_THIRD_BAR
	if value < healthbar.max_value * 0.01:
		healthbar_spritesheet.margin = EMPTY_BARs
