extends Area2D


export (int) var projectile_speed = 50
export (int) var damage = 1
export (int) var direction = 1

func _ready():
	$AnimationPlayer.play("Shoot")


func _physics_process(delta):
	position += (transform.x * projectile_speed * delta)


func _on_GenericProjectile_body_entered(body):
	# Check this group's owner and do damage to
	# opposing group
	if is_in_group("PlayerBullet") and body.is_in_group("Mob"):
		body.queue_free()
	queue_free()
