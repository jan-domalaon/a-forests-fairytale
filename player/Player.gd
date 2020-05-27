extends "res://character/Character.gd"



func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	input_player_movement()
	handle_move_animations()


func input_player_movement():
	var dir = 0
	if Input.is_action_pressed("move_right"):
		dir += 1
		$AnimatedSprite.set_flip_h(false)
	if Input.is_action_pressed("move_left"):
		dir -= 1
		$AnimatedSprite.set_flip_h(true)
		
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * move_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			handle_jump_animation()
			velocity.y = jump_speed


func handle_move_animations():
	if velocity.length() != 0:
		state_machine.travel("player_run")
	if velocity.length() == 0:
		state_machine.travel("player_idle")


func handle_jump_animation():
	state_machine.travel("player_jump")
