extends "res://character/Character.gd"

# Player can cast projectiles
export (PackedScene) var Projectile
var is_casting = false


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	# Only allow input if the player is still alive
	if not is_dead:
		input_player()
		handle_move_animations()


func input_player():
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
		if is_on_floor():
			handle_jump_animation()
			velocity.y = jump_speed
	
	if Input.is_action_just_pressed("spell_cast"):
		spell_cast()


func handle_move_animations():
	if velocity.length() != 0 and not is_casting:
		state_machine.travel("player_run")
	if velocity.length() == 0 and not is_casting:
		state_machine.travel("player_idle")


func handle_jump_animation():
	state_machine.travel("player_jump")


func spell_cast():
	is_casting = true
	state_machine.travel("player_cast")
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
