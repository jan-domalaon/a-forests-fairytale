extends Area2D


export (int) var damage = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_GenericTrap_body_entered(body):
	# Damage characters
	if body.is_in_group("Character"):
		body.get_damaged(damage)
