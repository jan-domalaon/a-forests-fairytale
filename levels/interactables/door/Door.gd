extends "res://levels/interactables/level_change/LevelChange.gd"


func open_door():
	if not locked:
		$Sprite.texture.set_region(Rect2(0, 0, 32, 41))
