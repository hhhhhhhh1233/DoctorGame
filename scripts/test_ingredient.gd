extends Area2D



func _on_body_entered(body):
	print("Collect!")
	body.ingredients["Foraged"] += 1
	queue_free()
