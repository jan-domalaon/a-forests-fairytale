extends "res://levels/interactables/generic_interactable/GenericInteractable.gd"

export (String) var level_path = ""
export (bool) var locked = false

var can_enter = false
var player

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]

func change_level():
	if not locked:
		player.set_is_level_changing(true)
		LevelChangeTransition.change_level_transition(level_path)
