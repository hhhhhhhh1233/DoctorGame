extends Node



func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			$"../Player/Camera/Panel".show()
		else:
			$"../Player/Camera/Panel".hide()
