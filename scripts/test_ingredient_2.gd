extends Area2D

func _on_body_entered(body):
	body.ingredients["Enemy"] += 1
	queue_free()
