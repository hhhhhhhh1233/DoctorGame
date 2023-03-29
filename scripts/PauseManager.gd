extends Node



func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			$"../CanvasLayer/PauseMenu".show()
			$"../CanvasLayer/PauseMenu/ResumeButton".grab_focus()
		else:
			$"../CanvasLayer/PauseMenu".hide()


func _on_resume_button_button_down():
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = false
	$"../CanvasLayer/PauseMenu".hide()


func _on_quit_button_button_down():
	get_tree().quit()
