extends RigidBody2D

var health = 3

func DecreaseHealth():
	health -= 1
	if health == 0:
		queue_free()
	$Polygon2D.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.1).timeout
	$Polygon2D.modulate = Color(1, 1, 1)

func delayedHurt(body):
	await get_tree().create_timer(1.0).timeout
	if body in $Hurtbox.get_overlapping_bodies():
		body.DecreaseHealth()
		if body.health > 0:
			delayedHurt(body)

func _on_hurtbox_body_entered(body):
	if body.name == "Player":
		body.DecreaseHealth()
		body.velocity.x += 200
		delayedHurt(body)
