extends "res://character/Character.gd"


const DROP_COLLISION_BIT = 1

# Limits of camera
export (int) var camera_limit_left 			= -10000000
export (int) var camera_limit_top 			= -10000000
export (int) var camera_limit_right 		= 10000000
export (int) var camera_limit_bottom 		= 10000000

# Player can cast projectiles
export (PackedScene) var Projectile
var is_casting = false
var is_level_changing = false setget set_is_level_changing
var is_jumping = false
var is_grounded = false
var collected_items = {"white": false, 
						"red": false, 
						"blue": false}

signal grounded_update(is_grounded)

func _ready():
	# Set camera limits
	set_camera_limits(camera_limit_left, camera_limit_top,
						camera_limit_right, camera_limit_bottom)
	
	# Connect to toggle hide UI if level needs
	get_parent().connect("hide_ui", self, "on_hide_ui")
	
	# Connect to timer to update UI
	get_parent().connect("update_time", self, "on_update_time")


func _physics_process(_delta):
	# Only allow input if the player is still alive
	if not (is_dead or is_level_changing):
		handle_input_player()
		handle_move_animations()
		check_is_jumping()
		handle_camera_movement_and_grounded()


func handle_input_player():
	var dir = 0
	if Input.is_action_pressed("move_right"):
		dir += 1
		flip_player_left(false)
	if Input.is_action_pressed("move_left"):
		dir -= 1
		flip_player_left(true)

	if dir != 0:
		velocity.x = lerp(velocity.x, dir * move_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

	if Input.is_action_just_pressed("jump"):
		if is_grounded:
			is_jumping = true
			handle_jump_animation()
			velocity.y = jump_speed

	if Input.is_action_just_pressed("spell_cast"):
		spell_cast()
	
	if Input.is_action_just_pressed("interact"):
		var interactables = $InteractArea.get_overlapping_areas()
		for interactable in interactables:
			if interactable.is_in_group('Door'):
				interactable.open_door()
			if interactable.is_in_group("LevelChange"):
				interactable.change_level()
		print(interactables)
	
	if Input.is_action_pressed("move_down"):
		# Handle dropping from platform logic
		set_collision_mask_bit(DROP_COLLISION_BIT, false)


func handle_move_animations():
	if velocity.length() != 0 and not is_casting:
		anim_state_machine.travel("player_run")
	if velocity.length() == 0 and not is_casting:
		anim_state_machine.travel("player_idle")


func handle_jump_animation():
	anim_state_machine.travel("player_jump")


func handle_death_animation():
	anim_state_machine.travel("death_anim")


func spell_cast():
	is_casting = true
	anim_state_machine.travel("player_cast")
	var spell = Projectile.instance()
	
	# owner refers to root node that the Player is in (ie level)
	owner.add_child(spell)
	
	# Indicate that this is a player made projectile
	spell.add_to_group("PlayerBullet")
	
	spell.transform = $SpellMuzzle.global_transform
	
	# Flip Sprite direction of player is looking left
	if $AnimatedSprite.flip_h:
		spell.set_scale(Vector2(-1, 1))


func flip_player_left(is_left):
	$SpellMuzzle.set_position(Vector2(-16, 0)) if is_left else $SpellMuzzle.set_position(Vector2(16, 0))
	$AnimatedSprite.set_flip_h(is_left)


func done_casting():
	is_casting = false


func set_camera_limits(left, top, right, bottom):
	$Camera2D.limit_left 	= left
	$Camera2D.limit_top 	= top
	$Camera2D.limit_right 	= right
	$Camera2D.limit_bottom 	= bottom


func set_is_level_changing(new_value):
	is_level_changing = new_value


func on_hide_ui():
	$PlayerUI/MarginContainer.hide()


func on_update_time(time_left):
	$PlayerUI/MarginContainer/Timer/MarginContainer/VBoxContainer/TimerLabel.text = str(time_left)


func check_is_grounded():
	is_grounded = not is_jumping and is_on_floor()


func check_is_jumping():
	if is_jumping and velocity.y >= 0:
		is_jumping = false


func check_is_on_platform():
	var is_on_platform = $PlatformDetector.is_colliding()


func handle_camera_movement_and_grounded():
	var was_grounded = is_grounded
	check_is_grounded()
	if ((was_grounded == null) or (is_grounded != was_grounded)):
		emit_signal("grounded_update", is_grounded)
